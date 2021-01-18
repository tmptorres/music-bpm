function [ ] = main( filename )

    info = audioinfo(filename);

    [y,Fs] = audioread(filename);
    y = y(:,1);                     % use just a mono track
    
    bpmRange = 25:1:250;
    
    % Sub-sampling
    factorSub = 32;
    if factorSub > Fs / (2*max(bpmRange)/60)
        error('This factor of subsampling will not work! Nyquist Limit!');
    else
%         [b,a] = butter(2,1/factorSub);
%         freqz(b,a); % See frequency response
%         y = filter(b,a,y);

        y = y(1:factorSub:end);
        
        Fs = round(Fs/factorSub);
    end    
    
    %% Plotting
    
    figure(1);
    
    t1 = (0:length(y)-1)/(Fs*60);
    subplot(3,1,1)
    plot(t1,y)
    title('Waveform')
    
    %% Crude approximation of autocorrelation
    disp('Method 1')
    [ bpm, r] = bpmCalc_AutoCorr(y, Fs, bpmRange);
    
    subplot(3,1,2)
    plot(bpmRange,r)
    ax = gca;
    ax.XTick = sort(unique([round( linspace(min(bpmRange),max(bpmRange),4) ), bpm]));
    title(sprintf('Autocorrelation. BPM:%.1f',bpm))
    xlabel('Bpm')
    
    %% Correlation to Sinusoid
    disp('Method 2')
    [ bpm, r ] = bpmCalc_SinCorr(y, Fs, bpmRange);
    
    subplot(3,1,3)
    plot(bpmRange,r)
    ax = gca;
    ax.XTick = sort(unique([round( linspace(min(bpmRange),max(bpmRange),4) ), bpm]));
    title(sprintf('Correlation to a Sinusoid. BPM:%.1f',bpm))
    xlabel('Bpm')
    
    %% Plot audio spectrum
    figure(2);
    plot_spectrum( y, Fs );
        
    keyboard;
end


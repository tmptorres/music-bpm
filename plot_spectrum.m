function [ P1, f ] = plot_spectrum( y, Fs )
% Plot single-side amplitude spectrum of x(t)

    T = 1/Fs;             % Sampling period
    L = length(y);        % Length of signal
    t = (0:L-1)*T;        % Time vector
    Y = fft(y);

    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    subplot(2,1,1);
    f = Fs*(0:(L/2))/L;
    plot(f,P1);
    title('Single-Sided Amplitude Spectrum of X(t)');
    xlabel('f (Hz)');
    ylabel('|P1(f)|');
    
    subplot(2,1,2);
    bpm = f*60;
    plot(bpm,P1);
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('bpm')
    ylabel('|P1(f)|')
end


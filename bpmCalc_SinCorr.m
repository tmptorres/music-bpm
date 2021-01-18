function [ bpm, r ] = bpmCalc_SinCorr(y, Fs, bpmRange)
   
    r = zeros(size(bpmRange));
    t = 0:1/(Fs*60):1;
    parfor i = 1:length(bpmRange)
        s = sin(2*pi*t*bpmRange(i));
        c = cos(2*pi*t*bpmRange(i));
        % Sin and Cos are orthogonal vectors, hence the average
        r(i) = 0.5* ( sum(xcorr(y,s).^2) + sum(xcorr(y,c).^2))/(length(s)^2);
    end
    [~,i] = max(abs(r));
    bpm = bpmRange(i);
end
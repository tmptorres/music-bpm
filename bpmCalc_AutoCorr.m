function [ bpm, r] = bpmCalc_AutoCorr(y, Fs, bpmRange)
    lags = round(Fs * 60 ./ bpmRange);
    r = myAutoCorr(y,lags);
    
    %aux = abs(r) > std(r)*5;
    %i = find(aux,1,'last');
    [~,i] = max(abs(r));
    bpm = bpmRange(i);
end
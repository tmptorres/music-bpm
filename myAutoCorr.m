function [ r ] = myAutoCorr(x,delays)
% Crude approximation of autocorrelation
    N = length(x);
    
    numAutoCorr = length(delays);
    r = zeros(1,numAutoCorr);
   
    parfor i = 1:length(delays)
        d = delays(i);
        r(i) = sum( x( 1+d:N ).*x( 1:N-d ) )/(N-d); % Unbiased
    end
end
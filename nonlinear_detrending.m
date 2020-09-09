clc
clear all
close all

%% generate signal
n=10000;
t=(1:n)';
k=10; %number of poles for random interpolation
slowdrift= interp1(100*randn(k,1),linspace(1,k,n),'pchip')'; % add slow polnomial drift
signal= slowdrift + 20*randn(n,1); %signal with slow polynomial drift

%% Bayes Information Criterion to find optimal order
orders=(5:40)'; %possible orders
sse1= zeros(length(orders),1); %sum of squared errors
for i1=1:length(orders)
    yhat=polyval(polyfit(t,signal,orders(i1)),t); %compute polynomial (fitting time series)
    sse1(i1)= sum((yhat-signal).^2)/n;%compute fit of model to data (sum of squared errors)
end
 bic=n*log(sse1) + orders*log(n); %bayes information criteria
[bestP, idx]= min(bic); %best parameter has lowest bic
polycoefs=polyfit(t,signal,orders(idx)); %Filter with best parameter (lowest BIC)
yhat=polyval(polycoefs,t); %polynomial fit
filtsig=signal-yhat;  %filtered signal

%% Plot
plot(t,signal,'k')
hold on
plot(t,yhat,'r','linew',2)
plot(t,filtsig,'b')
title('NonLinear Deterending')
xlabel('Time')
ylabel('Amplitude')
legend('Original Signal','Polynomial fit','Filteres Signal')

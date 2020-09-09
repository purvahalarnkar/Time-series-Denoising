clc
clear all
close all

%% create signal 
n=2000;
signal=cumsum(randn(1,n))+linspace(-30,30,n); %add linear trend

%% linear detrnding
signald=detrend(signal);
signalmean=mean(signal);
detrendmean=mean(signald); % mean after deterending is zero + computer rounding error

%% Plot
plot(1:n,signal,'k')
hold on
plot(1:n,signald,'r')
legend('Original signal','Detrend Signal')
title('Linear Detrending')
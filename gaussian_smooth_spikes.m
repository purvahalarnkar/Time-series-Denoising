clc
clear all
close all

%% generate time series of random spikes
n=300; %number of spikes
isi=round(exp(randn(n,1))*10); %inter spike interval (exponentially distributed)
spikes=0;
for i=1:n
    spikes(length(spikes)+isi(i))=1; %generate spikes 
end

%% Gaussian smooth filter
fwhm=25; %full width half maximum
k=100; %order of the filter
gtime=-k:k; %normalized time vector
gwin=exp(-(4*log(2)*gtime.^2)/fwhm^2); %gaussian window
gwin=gwin/sum(gwin); %Normalize gaussian to unit energy
filtsig=zeros(size(spikes)); %initialize filter signal
for i=k+1:length(spikes)-k-1
    filtsig(i)=sum(spikes(i-k:i+k).*gwin); %gaussian function
end

%% Plot
plot(spikes)
hold on
plot(filtsig,'linew',2)
title('Filtered Spikes')
legend('Original Spikes','Filteres Spikes')
xlabel('Time')
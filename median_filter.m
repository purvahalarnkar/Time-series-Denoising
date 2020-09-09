clc
clear all
close all

%% Create Signal
n=2000; %number of time points 
signal=cumsum(randn(n,1)); %generate signal
propnoise=5/100; %Percentage of time points to replace with noise
noisepoints=randperm(n);
noisepoints=noisepoints(1:round(n*propnoise)); %generate large noise spikes
signal(noisepoints)=50+rand(size(noisepoints))*100; %replace signal with noisy spikes
 
%% use histogram to pick threshold
subplot(211)
histogram(signal,100) % plot histogram
title('Histogram to pick threshold')
threshold=40; %visually picked threshold
suprathresh=(signal>threshold);  %find data values above threshold
 
%% Median filter
filtsig=signal;  %initialize filtered signal
%loop through suprathresshold points and to median of k
k=20; %actual window is k*2+1
for t=1:length(suprathresh)
    lower_bound=max(1,suprathresh(t)-k);
    upper_bound=min(suprathresh(t)+k,n);
    filtsig(suprathresh(t))=median(signal(lower_bound:upper_bound));
end

%% Plot
subplot(212)
plot(1:n,signal,1:n,filtsig)
title('Median Filter')
xlabel('Time')
ylabel('Amplitude')
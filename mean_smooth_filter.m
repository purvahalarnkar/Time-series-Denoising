clc
clear all
close all

%% Create the signal
srate= 1000; %Sampling Frequency (Hz)
time= 0:1/srate:3; %time vector
n= length(time); %number of time points
p=15; %poles for random interpolation
noiseamp=5; %noise: measured in standard deviation
amp=interp1(rand(p,1)*30,linspace(1,p,n)); %generate signal
noise= noiseamp*randn(size(time)); %generate noise
signal=amp+noise; %add noise to signal

%% Running mean filter
k=40; %order of the filter
filtsig= zeros(size(signal)); %initialize filtered signal vector
for i=k+1:n-k-1 
    filtsig(i)=mean(signal(i-k:i+k)); %mean of previous k and following k time points
end
windowsize= 1000*(k*2+1)/srate; %window size in ms 
                                %total number of points in the kernel=2*k+1
                            
%% Plot                         
plot(time,signal,'r')
hold on
plot(time,filtsig,'k','linew',2)
title('Running mean filter')
legend('Original Signal','Filtered Signal')
xlabel('Time')
ylabel('Amplitude')
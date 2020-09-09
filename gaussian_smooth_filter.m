clc
clear all
close all

%% Create Signal
srate= 1000; %Sampling frequency (Hz)
time= 0:1/srate:3; %Time vector 
n= length(time); %number of time points
p=15; %poles for random interpolation
noiseamp=5; %noise: measured in standard deviation
amp=interp1(rand(p,1)*30,linspace(1,p,n)); %generate signal
noise= noiseamp*randn(size(time)); %generate noise
signal=amp+noise; %add noise to signal

%% Gaussian Kernel
fwhm=25; %full width half maximum
k=100; %order of the filter
gtime=1000*(-k:k)/srate; %normalized time vector in ms
gwin=exp(-(4*log(2)*gtime.^2)/fwhm^2);%gaussian window
prepeakhalf=k+dsearchn(gwin(k+1:end)',0.5); %searching for time points cosest                                   
postpeakhalf=dsearchn(gwin(1:k)',0.5); % %to 0.5 (50% gain)
empfwhm= gtime(prepeakhalf)-gtime(postpeakhalf); % empirical fwhm
gwin=gwin/sum(gwin); %Normalize gaussian to unit energy

%% Gaussian smooth filter
filtsig=signal; %initialize filtered signal
for i=k+1:n-k-1
    filtsig(i)=sum(signal(i-k:i+k).*gwin); %gaussian function
end
%% Plot
subplot(121)
plot(gtime,gwin)
hold on
grid on
plot(gtime([prepeakhalf postpeakhalf]),gwin([prepeakhalf postpeakhalf]))
title(['Gaussian Kernel with requested FWHM ', num2str(fwhm), 'ms (',num2str(empfwhm), 'achieved )']) ;
xlabel('Time (ms)');
ylabel('Gain');
subplot(122)
plot(time,signal)
hold on
plot(time,filtsig,'linew',3)
title('Gaussian mean filter')
legend('Original Signal','Filtered Signal')
xlabel('Time')
ylabel('Amplitude')





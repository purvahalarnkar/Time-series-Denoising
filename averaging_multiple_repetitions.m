clc
clear all
close all

%% Create data with events
k=100; %duration of events in time points
event=diff(exp(-linspace(-2,2,k+1).^2)); %Create event (derivative of Gaussian)
event=event./max(event); %normalize to max=1
Nevents=30; %number of events 
onsettimes=randperm(10000-k); % Event onset times
onsettimes=onsettimes(1:Nevents);
data=zeros(1,10000); %initialize data
for i=1:Nevents
    data(onsettimes(i):onsettimes(i)+k-1); %put events into data
end
data=data+0.5*randn(size(data)); %add noise

%% Plot 
subplot(131)
plot(data)
title('Data with events')
xlabel('Time')
ylabel('Amplitude')
subplot(132)
plot(1:k,data(onsettimes(3):onsettimes(3)+k-1)) % Plot one event
hold on 
plot(1:k,event)
title('Event')
xlabel('Time')
ylabel('Amplitude')
legend('Averaged','Ground truth')
subplot(133)
plot(1:k,event)
title('Average Events')
xlabel('Time')
ylabel('Amplitude')
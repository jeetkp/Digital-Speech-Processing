clc;clear all; close all;
[wave2,F2]=audioread('2.wav');
[wave6,F6]=audioread('6.wav');
Q71(wave2,F2);
Q71(wave6,F6);

function [energy, ZC, wave, mag] = Q71(signal, Fs)
wave = signal;
len = 1000; %1000; %Window length
w = blackman(len); %Blackman window of length Lw samples
energy = conv(signal.^2, w.^2, 'same');

sign = @(x) (x >= 0) + (-1)*(x < 0);
signal_lagged = [0;signal(1:length(signal)-1)];
ZC = 0.5*conv(abs(sign(signal) - sign(signal_lagged)), w, 'same');
mag = conv(abs(signal), abs(w), 'same');

figure()
subplot(4,1,1)
plot(wave)
title('Signal Waveform');
subplot(4,1,2)
plot(mag/max(mag))
title('Signal Magnitude');
subplot(4,1,3)
plot(energy/max(energy))
title('Signal Energy');
subplot(4,1,4)
plot(ZC)
title('Signal Zero Crossing');
end
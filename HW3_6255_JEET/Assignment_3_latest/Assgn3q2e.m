clear all; clc; close all;
[wav1,fs1]=audioread('aarthi_aa.wav');
[wav2,fs2]=audioread('aarthi_AE.wav');
[wav3,fs3]=audioread('aarthi_uh.wav');
Fk = [500 1500 2500];
B = [200 400 600];
Fs = 16000;
%pole_magnitude_gain = [0.8 0.8 0.8];
pole_gain = 0.08;

abs_vals = exp(-pi*pole_gain.*B/Fs);
angles = exp(1j*2*pi*Fk/Fs);
conj_angles = conj(angles);
K = 10^(-2.5);%random value
all_roots = [abs_vals.*angles abs_vals.*conj_angles];
polynomial = poly(all_roots);
Z = [];

for k =0:1:8000
    x = exp(1j*2*pi*k/Fs);
    value = abs(polyval(polynomial, x));
    mag = 20*log10(K/value);
    check_val(k+1) = mag;
end

g = @(x) rem(x,80).*(0.96.^rem(x,80)).*(rem(x,80)>=0).*(rem(x,160)<=80);
T = 0.5;
length = linspace(0,T,Fs*T); 

f_p = fft(wav1(:,1)');
y_z = K*f_p./polyval(polynomial, exp(1j*2*pi*linspace(0,14640,14641)/Fs));
y_time = abs(ifft(y_z));

figure()
subplot(2,1,1);
plot(wav1(:,1));
title('AA signal');
subplot(2,1,2);
plot(y_time);
title('Pulse after vocal tract applying fft and then ifft');

figure()
plot(abs(y_z))
title('AA Wave');
xlim([0 3000])

f_p = fft(wav2(:,1)');
y_z = K*f_p./polyval(polynomial, exp(1j*2*pi*linspace(0,15839,15840)/Fs));

y_time = abs(ifft(y_z));

figure()
subplot(2,1,1);
plot(wav2(:,1));
title('AE wave');
subplot(2,1,2);
plot(y_time);
title('Pulse after vocal tract applying fft and then ifft');
% figure()
% plot(plot_val)
figure()
plot(abs(y_z))
title('AE Wave');
xlim([0 3000])
f_p = fft(wav3(:,1)');
y_z = K*f_p./polyval(polynomial, exp(1j*2*pi*linspace(0,15119,15120)/Fs));

y_time = abs(ifft(y_z));

figure()
subplot(2,1,1);
plot(wav3(:,1));
title('UH wave');
subplot(2,1,2);
plot(y_time);
title('Pulse after vocal tract applying fft and then ifft');

figure()
plot(abs(y_z))
title('UH Wave');
xlim([0 3000])
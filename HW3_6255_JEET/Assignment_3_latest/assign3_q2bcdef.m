clear all; clc; close all;
Fk = [500 1500 2500];
B = [200 400 600];
Fs = 16000;
pole_gain = 0.08;

abs_vals = exp(-pi*pole_gain.*B/Fs);
angles = exp(1j*2*pi*Fk/Fs);
conj_angles = conj(angles);
K = 10^(-2.5);
all_roots = [abs_vals.*angles abs_vals.*conj_angles];
polynomial = poly(all_roots);
Z = [];

for k =0:1:8000
    x = exp(1j*2*pi*k/Fs);
    value = abs(polyval(polynomial, x));
    mag = 20*log10(K/value);
    plot_val(k+1) = mag;
end

%Generate glottal pulse and feed into filter
g = @(x) rem(x,80).*(0.96.^rem(x,80)).*(rem(x,80)>=0).*(rem(x,160)<=80);
T = 0.5;
length = linspace(0,T,Fs*T); %Samples over half a second

g1 = @(x) rem(x,160).*(0.96.^rem(x,160)).*(rem(x,160)>=0).*(rem(x,320)<=160);
T1 = 0.5;
length1 = linspace(0,T1,Fs*T1);

f_p = fft(g(linspace(0,7999,8000)));
y = K*f_p./polyval(polynomial, exp(1j*2*pi*linspace(0,7999,8000)/Fs));

y_time = abs(ifft(y));
audiowrite('glotal80-160.wav',y_time,16000);
p8 = audioplayer(y_time,16000);
playblocking(p8);
f_p1 = fft(g1(linspace(0,7999,8000)));
y1 = K*f_p1./polyval(polynomial, exp(1j*2*pi*linspace(0,7999,8000)/Fs));

y_time1 = abs(ifft(y1));
audiowrite('glotal160-320.wav',y_time,16000);
p8 = audioplayer(y_time1,16000);
playblocking(p8);
figure()
subplot(2,1,1);
plot(length, g(linspace(0,7999,8000)));
title('Original Glottal pulse N=80');
subplot(2,1,2);
plot(length, y_time);
title('Pulse after vocal tract applying fft and then ifft');

figure()
subplot(2,1,1);
plot(length, g1(linspace(0,7999,8000)));
title('Original Glottal pulse N=160');
subplot(2,1,2);
plot(length1, y_time1);
title('Pulse after vocal tract applying fft and then ifft');

figure()
plot(plot_val)

figure()
plot(abs(y))
%freqz(K,polynomial);
figure()
plot(abs(y1))
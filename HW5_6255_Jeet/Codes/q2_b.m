clc; clear all; close all;
n= 0:100;
yy=sin(0.02*pi*n)

h = fft(yy);
logh = log(abs(h)) + sqrt(-1)*unwrap(angle(h));
y = real(ifft(logh));

subplot(1,2,1);
 plot(y)
 title('Complex spectra using recursive');
 subplot(1,2,2);
 plot(cceps(yy))
title(' Complex Spectra using MAtlab func')
figure()
subplot(1,2,1);
realycap= 0.5* (y+fliplr(y))
plot(realycap)
title(' Real Cepstra using recursice')
subplot(1,2,2);
plot(rceps(yy))
title(' Real Cepstra using MAtlab func')
clc; clear all; close all;
n= 0:400;
impulse = n==0;
y=zeros(1,400);

for i = 1:401
    if(i==100)
        y(i)= impulse(i)-0.85*impulse(i-99);
    else 
        y(i)= impulse(i);
    end
end

h = fft(y);
logh = log(abs(h)) + sqrt(-1)*unwrap(angle(h));
yy = real(ifft(logh));

ycap= zeros(1,401);
% ycap[0]=0;
ycap(1)=0;

for i = 2:400
    sum=0;
    for k= 1:i-1
        sum= sum+ (((k-1)/(i-1))*ycap(k)*(y(i-k+1)/y(1)));
    end
    ycap(i)= (y(i)/y(1)) -sum
end
subplot(1,3,1);
 plot(ycap)
 title('Complex spectra using recursive');
 subplot(1,3,2);
 plot(cceps(y))
title(' Complex Spectra using MAtlab func')
 subplot(1,3,3);
 plot(yy)
title(' Complex Spectra using fft func')
figure()
subplot(1,3,1);
realycap= 0.5* (ycap+fliplr(ycap))
plot(realycap)
title(' Real Cepstra using recursice')
subplot(1,3,2);
plot(rceps(y))
title(' Real Cepstra using MAtlab func')
subplot(1,3,3);
realyy= 0.5* (yy+fliplr(yy))
plot(realyy)
title(' Real Cepstra using fft func')
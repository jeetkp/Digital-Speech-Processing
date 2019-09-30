clc; clear all; close all;
n= 0:400
yy=zeros(1,401);
yy(1)=1;
yy(2)=-1;
yyy=zeros(1,401);
for i =1:400
    yyy(i)= 9*yy(i+1)-27*yy(i)
end

h = fft(yyy);
logh = log(abs(h)) + sqrt(-1)*unwrap(angle(h));
yyyy = real(ifft(logh));

y=fliplr(yyy);
ycap= zeros(1,401);
ycap(401)=log(abs(y(401)));

for i = 400:-1:1
    sum=0;
    for k= i:-1:400
        sum= sum+ (((k-1)/(i-1))*ycap(k)*(y(i-k+1)/y(401)));
    end
    ycap(i)= (y(i)/y(401)) -sum
end
subplot(1,3,1);
 plot(fliplr(ycap))
 title('Complex spectra using recursive');
 subplot(1,3,2);
 plot(cceps(y))
title(' Complex Spectra using MAtlab func')
 subplot(1,3,3);
 plot(yyyy)
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
realyyyy= 0.5* (yyyy+fliplr(yyyy))
plot(realyyyy)
title(' Real Cepstra using recursice')
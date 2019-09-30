clear all; close all; clc;
%1a
N=10;
% w=-pi:0.01:pi;
w=0:0.01:2*pi
a=0.9;
num=(1-((a^N)*exp(-j*w*N)))
den= (1-(a*exp(-j*w)))
afunc=(num./den) 
a=2;
num=(1-((a^N)*exp(-j*w*N)))
den= (1-(a*exp(-j*w)))
afunc1=(num./den) 
figure();
subplot(2,1,1);
plot(abs(afunc));
title('MAgnitude responce 1a where value of a=0.9');
subplot(2,1,2);
plot(abs(afunc1));
title('MAgnitude responce 1a where value of a=2');
pic1= sin(w*N/2)./sin(w/2)
figure();
plot(abs(pic1))
% a= @(w) 0.54*sin(w*N/2)/sin(w/2)
% b=@(w) 0.23*sin((N/2)*(w-((2*pi)/(N-1))))/sin((1/2)*(w-((2*pi)/(N-1)))) 
% c=@(w) 0.23*sin((N/2)*(w+((2*pi)/(N-1))))/sin((1/2)*(w+((2*pi)/(N-1))))
a=  0.54*sin(w*N/2)./sin(w/2)
b=0.23*sin((N/2)*(w-((2*pi)/(N-1))))./sin((1/2)*(w-((2*pi)/(N-1)))) 
c=0.23*sin((N/2)*(w+((2*pi)/(N-1))))./sin((1/2)*(w+((2*pi)/(N-1))))
title('Rectangular function 1b');
%  pic2=@(w) 0.54*sin(w*N/2)/sin(w/2) + 0.23*sin((N/2)*(w-((2*pi)/(N-1))))/sin((1/2)*(w-((2*pi)/(N-1)))) + 0.23*sin((N/2)*(w+((2*pi)/(N-1))))/sin((1/2)*(w+((2*pi)/(N-1))))
pic2=0.54*sin(w*N/2)./sin(w/2) + 0.23*sin((N/2)*(w-((2*pi)/(N-1))))./sin((1/2)*(w-((2*pi)/(N-1)))) + 0.23*sin((N/2)*(w+((2*pi)/(N-1))))./sin((1/2)*(w+((2*pi)/(N-1))))
figure();
hold on;

plot(abs(pic2))
plot(abs(a))
plot(abs(b))
plot(abs(c))
legend('final','a','b','c')
title('Hamming window 1c')
% n=-pi:0.01:pi;

pic= @(w) abs(j*w*exp(-j*w));
figure();
fplot(pic);
title('MAgnitude responce 3a');
pic1221= @(w) angle(j*w*exp(-j*w));
figure();
fplot(pic1221);
title('Phase plot 3a');

for n= 0:9 
    y(n+1)=(-1).^(n+1)/(n-5);
end
figure()
stem(y);
title('Plot for 3b');
for n= 0:9 
    y(n+1)=(-1).^(n)/(pi*(n-5)^2);
end
figure()
stem(y);
title('Plot for 3b');
%6
r = 0.9;
omega_0 = 0.1*pi;
eqn = @(x) 0.25*(0.9.^(3*x)).*((cos(omega_0*x*3)) + 3*cos(omega_0*x));
n = [-100:1:100];
F_last = (1/128)*fft(eqn(n),128);
figure();
plot(abs(F_last))
title('Plot for 6');

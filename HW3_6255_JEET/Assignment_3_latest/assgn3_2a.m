clc;clear all; close all;
%2b
n=0:999;
a=0.96;
w= n.*a.^n;
plot(w);
N=160;
clear w,a;
a=0.9;
w=-4*pi:0.001:4*pi;
f_r=(a*exp(-1i*w).*(1-a^N*exp(-1i*w*N))+N*a^N.*exp(-1i*w*N).*(1-a*exp(-1i*w)))./((1-a*exp(-1i*w)).^2);
figure();
plot(w,20*log10(abs(f_r)));
%2c
% a=1;
clear a,w;
f_r= @(a,w,N)(a*exp(-1i*w).*(1-a^N*exp(-1i*w*N))+N*a^N.*exp(-1i*w*N).*(1-a*exp(-1i*w)))./((1-a*exp(-1i*w)).^2);

t=0:0.0001:1;
g=zeros(1,length(t));
for i=1:length(t)
    q(i)=20*log10(abs(f_r(t(i),0,160)))-20*log10(abs(f_r(t(i),pi,160)));
    if(q(i)>60)
        break;
    end
    
end
t(i)
% i=1;
% figure();
% for w=0:2*pi;
%     num(i)= (a*exp(j*w))/((a-exp(j*w))^2);
%     hold on;
% %     plot(abs(num));
%     i=i+1;
% end
% plot(abs(num))
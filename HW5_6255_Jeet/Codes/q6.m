clc; clear all; close all;
[x,fs]=audioread('se.wav');  
inp = mean(x, 2);
inp = inp - mean(inp);
inp = 0.99*inp/max(abs(inp));
in = inp;

x=in

%number of FFT samples
N = 1024;
%Window Length
windowlength = 1024;
WinOverlap = 0.5;
size = length(x);
hops = WinOverlap*windowlength;
frames = floor(size/hops);
window = hamming(windowlength);
check=0; % Real Cepstr
check1=0; %Complex spectra
check2=0; % LP Complex Spectra

aa= zeros(10,1024);
bb= zeros(10,1024);
for m = 1:1:frames-1
    x_frame = x((hops*(m-1))+1:((hops*(m-1))+windowlength));
    [BNmag,BNmagn,c]=cepstral_liftering_speech(x_frame,1,window,windowlength,N);
    check=[check c];
    check1=[check1 BNmag];
    check2=[check2 BNmagn];
    if m<11
        aa(m,:)=BNmag;
        bb(m,:)=BNmagn;
    end   
 end
figure();
% hold on;
for i =1:10
    subplot(10,1,i)
    plot(aa(i,:))
    hold on;
    plot(bb(i,:))
    hold off;
end
figure();
subplot(3,1,1);
plot(check1);
title(" Log magnitude Spectra");
subplot(3,1,2);
plot(check);
title(" Real magnitude ceptra");
subplot(3,1,3);
plot(check2);
title(" Log magnitude low pass liftered Spectra");



figure()
plot(check1,'r')
hold on 
plot(check2,'b')
legend('Log spectra','liftered Spectra')
title('complex Spectra and low pass liftered complex spectra')


function [BNmag,BNmagn,c]=cepstral_liftering_speech(xin,ss,win,L,nfft)
    b=zeros(1,nfft);
    b(1:L)=xin(ss:ss+L-1).*win;
    
% compute spectrum, phase, unwrapped phase, compute complex cepstrum using
% regular matlab code;
    BN=fft(b,nfft);
    phase_rad=angle(BN);
    phase_rad_unwrap=unwrap(phase_rad);
    BNmag_ph=log(abs(BN))+phase_rad_unwrap*i;
    BNmag=real(BNmag_ph);
    xhat=ifft(BNmag_ph,nfft);
    xhats=real(xhat);
        c=(xhats+fliplr(xhats))/2;
        lifterl=20;
%         index=lifterl/20;
        lifter(1:nfft)=0;
        lifter(1:lifterl+1)=1;
        lifter(nfft-lifterl+1:nfft)=1;
        xhatl=real(xhat.*lifter);
        BNmagn=real(fft(xhatl,nfft));

end

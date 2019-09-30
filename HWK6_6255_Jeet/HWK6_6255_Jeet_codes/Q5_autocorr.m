clc; clear all; close all;
[x,fs]=audioread('ZH_fricative.wav');  
inp = mean(x, 2);
inp = inp - mean(inp);
inp = 0.99*inp/max(abs(inp));
in = inp;

x=in

%number of FFT samples
N = 480;
%Window Length
windowlength = 480;
WinOverlap = 0.5;
size1 = length(x);
hops = WinOverlap*windowlength;
frames = floor(size1/hops);
window = hamming(windowlength);
R=[];
E=[];
k=[];
alpha=[];
gain_mat=[];
% p=16;
p=50;
ShortTimeFourierTransform = zeros(frames,windowlength);
h_autocorrelation = zeros(frames,windowlength);
for m = 1:1:frames-1
    x_frame = x((hops*(m-1))+1:((hops*(m-1))+windowlength));
    xwindowed = window.*x_frame;
    ShortTimeFourierTransform(m,:) = fft(xwindowed)';
    [R_1,E_1,k_1,alpha_1,gain_mat_1]=autocorrelation(x_frame,windowlength,p);
    R= [R;R_1];
    E=[E;E_1];
    k=[k;k_1];
    alpha=[alpha;alpha_1];
    gain_mat = [gain_mat;gain_mat_1]; 
    
    alphap=alpha_1(1:p,p);
    num=[1 -alphap'];
    % ha=20*log10(G)-20*log10(abs(fft(num,nfft)));
    [h_autocorrelation(m,:),f1]=freqz(gain_mat_1,num,windowlength,'whole',fs);
    h(1) = alpha(p,1);
    for i = 2:1:p
    sumvar = 0;
    for l = 2:1:i-1
        term = (l/i)*h(l)*alpha(p,i-l);
        sumvar = sumvar+term;
    end
    h(i) = alpha(p,i) + sumvar;
    end
    ceps = h;
end

for i =1:5
    subplot(5,1,i);
plot(abs(ShortTimeFourierTransform(i,:)))
hold on
plot(abs(h_autocorrelation(i,:)))
title("Frame " + i)
end
clc; clear all; close all;
[x,fs]=audioread('aarthi_uh.wav');  
inp = mean(x, 2);
inp = inp - mean(inp);
inp = 0.99*inp/max(abs(inp));
in = inp;

x=in

N = 480;
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
p=16;
ShortTimeFourierTransform = zeros(frames,windowlength);
h_autocorrelation = zeros(frames,windowlength);
Area= zeros(frames,p+1);% in the algo the A(0) is 1. SInce matlab it starts from 1. so we set A(1) as 1
Area(:,1) = 1;
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
    for n = 1:p
        coeff = (1-k_1(n))/(1+k_1(n));
        Area(m,n+1) = coeff*Area(m,n);
    end
end
j=1;
for i  = 1:10
    subplot(10,2,j)
    bar(Area(i,:))
    title(" Area to glottis frame " + i)
    subplot(10,2,j+1)
    plot(abs(h_autocorrelation(i,:)))
    title(" LPC SPectra -  " + i)
    j=j+2;
end
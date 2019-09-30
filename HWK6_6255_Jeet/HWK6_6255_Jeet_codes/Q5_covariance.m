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
phim=[];
phiv=[];
EC=[];
alphac=[];
GC=[];
p=16;
ShortTimeFourierTransform = zeros(frames,windowlength);
h_covariance = zeros(frames,windowlength);
for m = 1:1:frames-1
    x_frame = x((hops*(m-1))+1:((hops*(m-1))+windowlength)+p);
    x_frame_1 = x((hops*(m-1))+1:((hops*(m-1))+windowlength));
    xwindowed = window.*x_frame_1;
    ShortTimeFourierTransform(m,:) = fft(xwindowed)';
    [phim_1,phiv_1,EC_1,alphac_1,GC_1]=covariance(x_frame,windowlength,p);
    phim= [phim;phim_1];
    phiv=[phiv;phiv_1];
    EC=[EC;EC_1];
    alphac=[alphac;alphac_1];
    GC = [GC;GC_1];  
    numc=[1  -alphac'];
    [h_covariance(m,:),f1]=freqz(GC_1,numc,windowlength,'whole',fs);
end

for i =1:5
    subplot(5,1,i);
plot(abs(ShortTimeFourierTransform(i,:)))
hold on
plot(abs(h_covariance(i,:)))
title("Frame " + i)
end
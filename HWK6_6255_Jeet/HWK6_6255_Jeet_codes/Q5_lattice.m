clc; clear all; close all;
[x,fs]=audioread('ZH_fricative.wav');  
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
EL=[];
phiv=[];
k=[];
alpha1=[];
GL=[];
p=16;
ShortTimeFourierTransform = zeros(frames,windowlength);
h_lattice = zeros(frames,windowlength);
for m = 1:1:frames-1
    x_frame = x((hops*(m-1))+1:((hops*(m-1))+windowlength+p));
    x_frame_1 = x((hops*(m-1))+1+p:((hops*(m-1))+windowlength+p));
    xwindowed = window.*x_frame_1;
    ShortTimeFourierTransform(m,:) = fft(xwindowed)';
    [EL_1,alpha1_1,GL_1,k_1]=lattice(x_frame,windowlength,p);
    EL= [EL;EL_1];
    k=[k;k_1];
    alpha1=[alpha1;alpha1_1];
    GL = [GL;GL_1];  
    alphalat=alpha1_1(:,p);
    numl=[1 -alphalat'];
    [h_lattice(m,:),f1]=freqz(GL_1,numl,windowlength,'whole',fs);
end


for i =1:5
    subplot(5,1,i);
plot(abs(ShortTimeFourierTransform(i,:)))
hold on
plot(abs(h_lattice(i,:)))
title("Frame - " + i)
end
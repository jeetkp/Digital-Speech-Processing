clear all;close all; clc;
[x,fs]= audioread('6.wav');
%number of FFT samples
N = 1024;
%Window Length
windowlength = 1024;
%signal should have overlap
WinOverlap = 0.5;
size = length(x);
hops = WinOverlap*windowlength;
frames = floor(size/hops);
ShortTimeFourierTransform = zeros(windowlength,frames);
window = hamming(windowlength);

for m = 1:1:frames-1
    x_frame = x((hops*(m-1))+1:((hops*(m-1))+windowlength));
    xwindowed = window.*x_frame;
    ShortTimeFourierTransform(:,m) = fft(xwindowed);
end

for k = 1:1:floor(frames/2)
%     ShortTimeFourierTransform_Downsampled(:,k) = ShortTimeFourierTransform(:,2*k);
    ShortTimeFourierTransform_Downsampled(:,k) = ShortTimeFourierTransform(:,2*k);
end

frames = floor(frames/2);

%Inverse Short time fourier transform of downsampled signal.
downsampled_length = length(ShortTimeFourierTransform_Downsampled(:,2));
windowlength = downsampled_length;
hops = WinOverlap*windowlength;
xlen = downsampled_length + (frames-1)*hops;
downsampled_Signal = zeros(xlen,1);

%Inverse Short Time fourier transform for Downsampled signal
for k = 0:hops:(hops*(frames-1))
    frame_select = ShortTimeFourierTransform_Downsampled(:,1+k/hops)';
    real_part = real(ifft(frame_select));
    %we take only real part
    downsampled_Signal(k+1:k+1024) = downsampled_Signal(k+1:k+1024) + real_part'.*window;
end



%Performing 0 padding to get back the length of original signal
for k = 1:1:floor(frames/2)
    ShortTimeFourierTransform_zeroPadded(:,k) = [ShortTimeFourierTransform_Downsampled(:,k);zeros(N,1)];
end



%Inverse Short time forier trasnform on 0 padded signal.
zeroPadded_length = length(ShortTimeFourierTransform_zeroPadded(:,2));
windowlength = zeroPadded_length;
hops = WinOverlap*windowlength;

xlen = zeroPadded_length + (frames-1)*hops;
zeroPadded_signal = zeros(xlen,1);
for k = 0:hops:(hops*(frames-1))
    frame_select = ShortTimeFourierTransform_Downsampled(:,1+k/hops)';
    real_part = real(ifft(frame_select));
    %we take only real part
    zeroPadded_signal(k+1:k+1024) = zeroPadded_signal(k+1:k+1024) + real_part'.*window;
end


figure()
subplot(3,1,1)
plot(x)
title('6.wav Signal');
subplot(3,1,2)
plot(downsampled_Signal)
title('Time Accelerated 6.wav');
subplot(3,1,3)
plot(zeroPadded_signal)
title('0 padded signal 6.wav');

sound(x,fs);
sound(downsampled_Signal,fs);
sound(zeroPadded_signal,fs);
audiowrite('6_zeropadded.wav',downsampled_Signal,fs);
audiowrite('6_accerelated.wav',downsampled_Signal,fs);
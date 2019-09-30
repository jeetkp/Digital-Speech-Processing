clc;clear all; close all;
%8b downsample by 4 and save
[wave4, F_4] = audioread('4.wav');
wav4downby4 = downsample(wave4,4);
[wave8, F_8] = audioread('8.wav');
wav8downby4 = downsample(wave8,4);
audiowrite('4_downsampled.wav',wav4downby4,4000);
audiowrite('8_downsampled.wav',wav8downby4,4000);

%8c filter and then downsample by 4.. Cut off frequency choosen 2000Hz. In
%ellip filter I have used as 0.25. 
[wave3,F_3] = audioread('3.wav');
[wave7,F_7] = audioread('7.wav');

% fil_3 = fft(wave3);
% fil_7 = fft(wave7);
% wave_cutoff = [100 4000]/(F3/2);
% 
% [b,a] = butter(6,wave_cutoff);
% fvtool(b,a);
[b,a] = ellip(6,0.1,40,.4);
f3_filtered = filter(b,a,wave3);
f7_filtered = filter(b,a,wave7);

filterWav3downby4 = downsample(f3_filtered,4);
filterWav7downby4 = downsample(f7_filtered,4);
audiowrite('3_filter_downsampled.wav',filterWav3downby4,4000);
audiowrite('7_filter_downsampled.wav',filterWav7downby4,4000);

%8d resample to 3000hz and downsample by 4.
p=3000;%final frquecy
q=16000;%inital sampled frequency
resampledWav3_3000_filtered = resample(f3_filtered,p,q);
resampledWav3_3000 = resample(wave3,p,q);
resampledWav7_3000 = resample(wave7,p,q);
audiowrite('3_3000Hz.wav',resampledWav3_3000,3000);
f3_filtered_3000 = filter(b,a,wave7);
audiowrite('3_3000Hz_filtered.wav',resampledWav3_3000,3000);
down3_1 = downsample(resampledWav3_3000_filtered,4);
down3 = downsample(resampledWav3_3000,4);
down7 = downsample(resampledWav7_3000,4);
audiowrite('3_3000_filtered_down.wav',down3_1,750);
audiowrite('3_3000_down.wav',down3,750);
audiowrite('7_3000_down.wav',down7,750);
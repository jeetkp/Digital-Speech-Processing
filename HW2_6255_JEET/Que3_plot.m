clear all; close all; clc;
[AA, F_AA] = audioread('aarthi_aa.wav');
[IY, F_IY] = audioread('aarthi_AE.wav');
[UH, F_UH] = audioread('aarthi_uh.wav');

line_spacing_1 = linspace(-pi,pi,256);
line_spacing_2 = linspace(-pi,pi,1024);

dft_256_AA = fft(AA(1:256,1), 256);
dft_1024_AA = fft(AA(1:1024,1), 1024);

%Plots
figure;
subplot(1,2,1)
stem(line_spacing_1, abs(dft_256_AA))
title('Plots for 256 pt dft of AA');
subplot(1,2,2)
stem(line_spacing_2, abs(dft_1024_AA))
title('Plots for 1024pt dft of AA');

dft_256_IY = fft(IY(1:256,1), 256);
dft_1024_IY = fft(IY(1:1024,1), 1024);

figure;
subplot(1,2,1)
stem(line_spacing_1, abs(dft_256_IY))
title('Plots for 256pt dft of IY');
subplot(1,2,2)
stem(line_spacing_2, abs(dft_1024_IY))
title('Plots for 1024pt dft of IY ');

dft_256_UH = fft(UH(1:256,1), 256);
dft_1024_UH = fft(UH(1:1024,1), 1024);

figure;
subplot(1,2,1)
stem(line_spacing_1, abs(dft_256_UH))
title('Plots for 256pt dft of UH');
subplot(1,2,2)
stem(line_spacing_2, abs(dft_1024_UH))
title('Plots for 1024pt dft of UH');



%Replace last 3/4th of 1024segments by 0:
dft_1024_AA_replaced = AA(1:1024,1);
dft_1024_AA_replaced(257:1024) = 0;
dft_1024_AA_replaced = fft(dft_1024_AA_replaced,1024);

figure;
subplot(1,2,1)
stem(line_spacing_2, abs(dft_1024_AA_replaced))
title('Plots for AA after replacement with 0 in (3/4) 1024 bit sample');
subplot(1,2,2)
stem(line_spacing_2, abs(dft_1024_AA))
title('AA Before replacement');

dft_1024_IY_replaced = IY(1:1024,1);
dft_1024_IY_replaced(257:1024) = 0;
dft_1024_IY_replaced = fft(dft_1024_IY_replaced,1024);

figure;
subplot(1,2,1)
stem(line_spacing_2, abs(dft_1024_IY_replaced))
title('Plots for IY after replacement with 0 in (3/4) 1024 bit sample');
subplot(1,2,2)
stem(line_spacing_2, abs(dft_1024_IY))
title('IY Before replacement');

dft_1024_UH_replaced = UH(1:1024,1);
dft_1024_UH_replaced(257:1024) = 0;
dft_1024_UH_replaced = fft(dft_1024_UH_replaced,1024);

figure;
subplot(1,2,1)
stem(line_spacing_2, abs(dft_1024_UH_replaced))
title('Plots for UH after replacement with 0 in (3/4) 1024 bit sample');
subplot(1,2,2)
stem(line_spacing_2, abs(dft_1024_UH))
title('UH Before replacement');
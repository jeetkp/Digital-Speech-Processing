clear all; close all; clc;
% by 0
%length(500)
y = randn(1,500); %Input white noise
window = rectwin(100);
N = 100;
n = 0;
k_lim = 21; %For length of k
for k = 1:1:k_lim
    r = 0;
    for m = 1:1:N-k+1
        r = r + y(n+m)*window(m)*y(n+m+k-1)*window(n+m+k-1);
    end
    R(k) = r;
end

R = (1/k_lim)*R;
figure();
x_axis = linspace(0,k_lim-1,k_lim);
stem(x_axis, R)
title('Length of sequence 500 for k=20');

k_lim = 51; %For length of k
for k = 1:1:k_lim
    r = 0;
    for m = 1:1:N-k+1
        r = r + y(n+m)*window(m)*y(n+m+k-1)*window(n+m+k-1);
    end
    R(k) = r;
end

R = (1/k_lim)*R;
figure();
x_axis = linspace(0,k_lim-1,k_lim);
stem(x_axis, R)
title('Length of sequence 500 and k=50');
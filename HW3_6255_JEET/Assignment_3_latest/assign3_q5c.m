clear all; close all; clc;
% by pi and pi/2
x = randn(1,500); %Input white noise

N = 500;
a = 0.95;
y = zeros(1,500);
window = rectwin(N);
for i = 1:1:N %Generate y of length 1000
    if(i==1)
        y(i) = x(i);
    else
        y(i) = x(i) - a*y(i-1);
    end
end

n = 0;
k_lim = 21; %For length of k
for k = 1:1:k_lim
    r = 0;
    for m = 1:1:N-k+1
        r = r + y(n+m)*window(m)*y(n+m+k-1)*window(n+m+k-1);
    end
    R(k) = r;
end

R = (1/N)*R;
figure();
x_axis = linspace(0,k_lim-1,k_lim);
stem(x_axis, R)

n = 0;
k_lim = 51; %For length of k
for k = 1:1:k_lim
    r = 0;
    for m = 1:1:N-k+1
        r = r + y(n+m)*window(m)*y(n+m+k-1)*window(n+m+k-1);
    end
    R(k) = r;
end

R = (1/N)*R;
figure();
x_axis = linspace(0,k_lim-1,k_lim);
stem(x_axis, R)

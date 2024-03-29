clc;clear all;close all;
window_length = 1000; %Minimum length, else w[n+k] will be identically zero

g = @(x) rem(x,240)*(0.96^rem(x,240))*(rem(x,240)>=0)*(rem(x,240)<=160);
%g = @(x) (x)*(0.96^(x))*(x>=0)*(x<=160); %Assume nonperiodic
window = rectwin(window_length)';

N = 1000;
window_length = N;
window = rectwin(window_length)';

a = 0.96;
y = zeros(1,N);
for i = 1:1:N %Generate y of length 1000
    if(i==1)
        y(i) = g(i);
    else
        y(i) = g(i) - a*y(i-1);
    end
end

R = zeros(1,500);
R_mod = zeros(1,500);
n = 0; %n-value

for k = 1:1:501
    r = 0;
    r_dash = 0;
    for m = 1:1:(N-k+1)
        r = r + y(n+m)*window(n+m)*y(n+m+k-1)*window(n+m+k-1);
    end
    for m = 1:1:(N-500)-1
        r_dash = r_dash + y(n+m)*y(n+m+k-1);
    end
    R(k) = r/N;
    R_mod(k) = r_dash/N;
end
plot(R);
figure();
plot(R_mod);

N = 5000;
window_length = N;
window = rectwin(window_length)';

a = 0.96;
y = zeros(1,N);
for i = 1:1:N %Generate y of length 1000
    if(i==1)
        y(i) = g(i);
    else
        y(i) = g(i) - a*y(i-1);
    end
end

R = zeros(1,500);
R_mod = zeros(1,500);
n = 0; %n-value

for k = 1:1:501
    r = 0;
    r_dash = 0;
    for m = 1:1:(N-k+1)
        r = r + y(n+m)*window(n+m)*y(n+m+k-1)*window(n+m+k-1);
    end
    for m = 1:1:(N-500)-1
        r_dash = r_dash + y(n+m)*y(n+m+k-1);
    end
    R(k) = r/N;
    R_mod(k) = r_dash/N;
end
figure();
plot(R);
figure();
plot(R_mod);



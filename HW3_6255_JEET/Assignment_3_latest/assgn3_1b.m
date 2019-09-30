clc;clear all; close all;

f1 = @(x) 8*tan((2*pi*x*6)/35000) %- cot(2*pi*x*9/35000);
f2 = @(x) cot(2*pi*x*9/35000);
figure();
fplot(f1);
axis([0 10000 -100 100]);
hold on;
fplot(f2);
% P=interX(f1,f2);

f1 = @(x) (1/8)*tan((2*pi*x*13)/35000) %- cot(2*pi*x*9/35000);
f2 = @(x) cot(2*pi*x*4/35000);
figure();
fplot(f1);
axis([0 10000 -100 100]);
hold on;
fplot(f2);

f1 = @(x) (1/7)*tan((2*pi*x*8)/35000) %- cot(2*pi*x*9/35000);
f2 = @(x) cot(2*pi*x*9/35000);
figure();
fplot(f1);
axis([0 10000 -100 100]);
hold on;
fplot(f2);

f1 = @(x) (1)*tan(0) %- cot(2*pi*x*9/35000);
f2 = @(x) cot(2*pi*x*17/35000);
figure();
fplot(f1);
axis([0 10000 -100 100]);
hold on;
fplot(f2);
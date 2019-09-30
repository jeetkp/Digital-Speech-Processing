clc; clear all; close all;
[data, Fs1] = audioread('female3.wav');
inp = mean(data, 2);
inp = inp - mean(inp);
inp = 0.99*inp/max(abs(inp));
in = inp;

data=in
[data2,Fs2] = audioread('male3.wav');
inp = mean(data2, 2);
inp = inp - mean(inp);
inp = 0.99*inp/max(abs(inp));
in = inp;

data2=in

p = 16;
windowLength = 480;
winOverlap = 0.5;
size1 = length(data);
hopdist = winOverlap*windowLength;

framenum = floor(size1/hopdist);
ceps1 = zeros(framenum, p);

for m = 1:1:framenum-1
    xf1 = data((hopdist*(m-1))+1:((hopdist*(m-1))+windowLength));
    ceps1(m,:) = autocorrelation_ceps(xf1, windowLength, p);
end

N = framenum;
size1 = length(data2);
hopdist = winOverlap*windowLength;

framenum = floor(size1/hopdist);
ceps2 = zeros(framenum, p);

for m = 1:1:framenum-1
    xf2 = data2((hopdist*(m-1))+1:((hopdist*(m-1))+windowLength));
    ceps2(m,:) = autocorrelation_ceps(xf1, windowLength, p);
end

M = framenum;
distmat = zeros(N,M);
for i = 1:1:N
    for j = 1:1:M
        distmat(i,j) = norm((ceps1(i,:)- ceps2(j,:)));
    end
end

n=N;
m=M;
k=1;
w=[];
w(1,:)=[n,m];
pathmat = zeros(N,M);
pathmat(N,M) = 1;
distance = 0;

while ((n+m)~=2)
    if(n-1)==0
        m=m-1;
        pathmat(n,m) = 1;
        distance = distance + distmat(n,m);
    elseif (m-1)==0
        n=n-1;
        pathmat(n,m) = 1;
        distance = distance + distmat(n,m);
    else
      if((N-n) >= 0.5*(M-m) && (N-n) <= 2*(M-m))
      [values,number]=min([distmat(n-1,m),distmat(n,m-1),distmat(n-1,m-1)]);
      switch number
      case 1
        n=n-1;
        pathmat(n,m) = 1;
        distance = distance + distmat(n,m);
      case 2
        m=m-1;
        pathmat(n,m) = 1;
        distance = distance + distmat(n,m);
      case 3
        n=n-1;
        m=m-1;
        pathmat(n,m) = 1;
        distance = distance + distmat(n,m);
      end
      else
        n=n-1;
        m=m-1;
        pathmat(n,m) = 1;
        distance = distance + distmat(n,m);
      end
    end
    k=k+1;
    w=cat(1,w,[n,m]);
end


distance
clear all; close all; clc;
k=3
mu1 = 0.2;      % Mean
sigma1 = 0.1975;    % Sigma
mu2 = 1;
sigma2 = 0.1975;
X = importdata('hw5-gmm.txt');
X1=0;
X2=0;

%Initial Guess
for i=1:5000
    if(X(i)<0.5)
        X1=[X1 X(i)];
    else
        X2=[X2 X(i)];
    end
end
X1= X1(2:size(X1(:),1));
X2= X2(2:size(X2(:),1));

%Guessed data
x = [-.5:0.0001:1.8];
% y1 = GuassPDF(x, mu1, sigma1);
% y2 = GuassPDF(x, mu2, sigma2);
% % y3 = GuassPDF(x, mu3, sigma3);
% hold off;
% plot(x, y1, 'b-');
% hold on;
% plot(x, y2, 'r-');
% % plot(x, y3, 'g-');
% plot(X1, zeros(size(X1)), 'bx', 'markersize', 10);
% plot(X2, zeros(size(X2)), 'rx', 'markersize', 10);
m = size(X, 1);

% Set 'k' to the number of clusters to find.
k = 5;

% Randomly select k data points to serve as the means.
rindex = randperm(m);
mu = zeros(1, k);
for (i = 1 : k)
    mu(i) = X(rindex(i)); % Mean
    sigma(i)= (var(X)); %Variance
    phi(i)= 1/k;% Prior Probabilities. 
end
W = zeros(m, k);
w1=zeros(1,200)
% figure();
% Loop until convergence.
for (iter = 1:200)
    %Expectation
    pdf = zeros(m, k);
    
    % For each cluster...
    for (j = 1 : k)
        pdf(:, j) = GuassPDF(X, mu(j), sigma(j));
    end
    
    % Multiply each pdf value by the prior probability for each cluster.
    pdf_w = bsxfun(@times, pdf, phi);
    
    % Divide the weighted probabilities by the sum of weighted probabilities for each cluster.
    %   sum(pdf_w, 2) -- sum over the clusters.
    W = bsxfun(@rdivide, pdf_w, sum(pdf_w, 2));
    w1(iter)=(max(max(W)));
%     hold on;
    %Maximization
    prevMu = mu;    
    
    % For each of the clusters...
    for (j = 1 : k)
        phi(j) = mean(W(:, j));
        mu(j) = AverageWeight(W(:, j), X);
        variance = AverageWeight(W(:, j), (X - mu(j)).^2);
        sigma(j) = sqrt(variance);
    end
    phi
    % Check for convergence.
    if (mu == prevMu)
        break
    end

% End of Expectation Maximization loop.    
end
%STEP 4: Plot the data points and their estimated pdfs.
% hold off;
figure();
plot(w1)
title('loglihood vs no of iterations')
figure();
y1 = GuassPDF(x, mu1, sigma1);
y2 = GuassPDF(x, mu2, sigma2);
% y3 = GuassPDF(x, mu3, sigma3);

hold off;
plot(x, y1, 'b-');
hold on;
plot(x, y2, 'r-');
plot(X1, zeros(size(X1)), 'bx', 'markersize', 10);
plot(X2, zeros(size(X2)), 'rx', 'markersize', 10);
x = [-.5:0.0001:1.8];
y1 = GuassPDF(x, mu(1), sigma(1));
y2 = GuassPDF(x, mu(2), sigma(2));
y3 = GuassPDF(x, mu(3), sigma(3));
y4 = GuassPDF(x, mu(4), sigma(4));
y5 = GuassPDF(x, mu(5), sigma(5));
% Plot over the existing figure, using black lines for the estimated pdfs.
plot(x, y1, 'k-');
plot(x, y2, 'k-');
plot(x, y3, 'k-');
plot(x, y4, 'k-');
plot(x, y5, 'k-');

clear all;
X1 = importdata('hw5-gmm.txt');
hold on;
GMModel = fitgmdist(X1,3);
plot(X1,pdf(GMModel,X1),'.');
legend('Guessed Spectrum 1','Guessed Spectrum 2','points','points','Calculated by EM','Calculated by EM','Calculated by EM','Calculated by EM','Calculated by EM','Calculated by inbuilt function')
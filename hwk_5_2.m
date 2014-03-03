clear; clc;

% Create an array of 1000 values from a Gaussian with zero mean and one stddev
x = randn(1000,1);

% Create an array of 1000 values from a Gaussian with zero mean and 3 stddev
y = 3*randn(1000,1);

%PLot histograms
figure('Name','CDF comparison of Gaussians with Standard deviation 1 vs. 3');
subplot(1,2,1);
hist(x,[-3.5:0.5:3.5]);
xlabel('Value');
ylabel('Number of values');
title('Standard deviation = 1');
subplot(1,2,2);
hist(y,[-14.5:2.07:14.5]);
xlabel('Value');
ylabel('Number of values');
title('Standard deviation = 3');

%Create and plot CDFs
[nx, xb] = hist(x,[-10:0.001:10]);
[ny, yb] = hist(y,[-10:0.001:10]);

xx = cumsum(nx/sum(nx)); %normalized CDF function to max=1
yy = cumsum(ny/sum(ny));

figure();
plot(xb,xx,'r');
hold on;
plot(yb,yy,'b');
xlabel('Value');
ylabel('Cumulative Distribution');
title('CDF Comparison');
legend('stddev = 1','stddev = 3');

% Compute Smirnov test stastic
D_s = max(abs(xx-yy));

%Find D_S value for confidence of 0.1
D_s_1 = (-(1/2)*((1/1000)+(1/1000))*log(0.1/2))^(1/2);

fprintf('For the null hypothesis to be rejected with confidence 0.1, D_s > %4.5f\n',D_s_1);
fprintf('D_s = %4.5f, which is greater than the needed value\n',D_s);
fprintf('The null hypothesis is rejected with a confidence of 0.1\n\n');

% Find number of runs needed to find at least 1 non-reject at 0.1 confidence
[h, p, D_s_1lim] = kstest2(x,y,0.1);

fprintf('One not rejected conclusion at 0.1 confidence level occurs every %1.5e runs\n\n',p);

% Compute chi-squared value
for i=1:1000
   diff(i) = ((y(i)-x(i))^2)/x(i);
end

chi2 = sum(diff);

fprintf('chi-squared = %4.5f\n',chi2);

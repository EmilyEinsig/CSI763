clear; clc;

x = [1 2 3 4 5 6 7 8 9 10];
y = 5*x+4;
r = rand(1,10);
y = y-50.*r; % Create y-values

% Compute slope and intercept for OLS(X|Y) and OLS(Y|X)
Sxx = sum((x-mean(x)).^2);
Syy = sum((y-mean(y)).^2);
Sxy = sum((x-mean(x)).*(y-mean(y)));

b_xy = Sxy/Sxx;

b_yx = Syy/Sxy;

% Compute intercept using a = mean(y)-b*mean(x)
a_xy = mean(y)-b_xy*mean(x);

a_yx = mean(y)-b_yx*mean(x);

fprintf('OLS[X|Y]: b = %4.5f, a = %4.5f\n',b_xy,a_xy);
fprintf('OLS[Y|X]: b = %4.5f, a = %4.5f\n',b_yx,a_yx);

% Plot scatter with lines
fxy = a_xy+b_xy*x;
fyx = a_yx+b_yx*x;
figure();
scatter(x,y,'.');
title('Scatter Plot OLS Comparison');
hold on;
plot(x,fxy,'r');
plot(x,fyx,'g');
legend('Points','OLS[X|Y]','OLS[Y|X]');

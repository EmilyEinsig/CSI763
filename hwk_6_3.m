clear; clc;

% m = 10
% Create time series using fiter function
x10 = randn(10, 1);
y10 = filter(1, [1 -0.6 0.08 0.2 0.1 -0.04 1 0.05 0.5 -0.3], x10);

% Create A matrix for slash operation
A10 = zeros(10);

for i=1:10
    A10(i,i) = x10(i);
end

b_10 = A10\y10

figure('Name','m = 10');
plot(x10,y10,'r');
hold on;
plot(A10*b_10,y10,'b');
legend('Original','Calculated');

% m = 3
% Create time series using fiter function
x3 = randn(3, 1);
y3 = filter(1, [0.08 0.2 -0.04], x3);

% Create A matrix for slash operation
A3 = zeros(3);

for i=1:3
    A3(i,i) = x3(i);
end

b_3 = A3\y3

figure('Name','m = 3');
plot(x3,y3,'r');
hold on;
plot(A3*b_3,y3,'b');
legend('Original','Calculated');

% m = 12
% Create time series using fiter function
x12 = randn(12, 1);
y12 = filter(1, [1 -0.6 0.08 0.2 0.1 -0.04 1 0.05 0.5 -0.3 -0.5 0.4], x12);

% Create A matrix for slash operation
A12 = zeros(12);

for i=1:12
    A12(i,i) = x12(i);
end

b_12 = A12\y12

figure('Name','m = 12');
plot(x12,y12,'r');
hold on;
plot(A12*b_12,y12,'b');
legend('Original','Calculated');

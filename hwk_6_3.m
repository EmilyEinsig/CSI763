clear; clc;

% m = 10
% Create time series using fiter function
u = randn(40, 1);
z10 = filter(1, u, [1 -0.6 0.08 0.2 0.1 -0.04 1 0.05 0.5 -0.3]);

z10=z10';

% Create matrix A from u values for slash operation
for i=1:10
    for j=1:10
        k = 10-i+1+j-1;
        A_10(j,i) = u(k);
    end
end

b_10 = A_10\z10

% Using same u, determine what b is for m=3
z3 = filter(1, u, [0.6 0.2 -0.04]);

z3=z3';

% Create matrix A from u values for slash operation
for i=1:3
    for j=1:3
        k = 3-i+1+j-1;
        A_3(j,i) = u(k);
    end
end

b_3 = A_3\z3

% Using same u, determine what b is for m=12
z12 = filter(1, u, [0.05 -0.08 0.6 0.7 1 -0.2 0.3 0.6 0.4 0.4 0.2 -0.04]);

z12=z12';

% Create matrix A from u values for slash operation
for i=1:12
    for j=1:12
        k = 12-i+1+j-1;
        A_12(j,i) = u(k);
    end
end

b_12 = A_12\z12

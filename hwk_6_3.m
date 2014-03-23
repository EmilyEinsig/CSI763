clear; clc;

% m = 10
% Create time series using fiter function
u = randn(40, 1);
z10 = filter(1,[1 -0.6 0.08 0.2 0.1 -0.04 1 0.05 0.5 -0.3],u);


% Create matrix A from u values for slash operation
for i=1:10
    for j=1:30
        k = 10-i+1+j-1;
        A_10(j,i) = u(k);
    end
end

% Remove first 10 points from z10
z_10 = z10(11:end);

b_10 = A_10\z_10


% Using same u, determine what b is for m = 3
z3 = filter(1,[0.6 0.2 -0.04],u);

% Create matrix A from u values for slash operation
for i=1:3
    for j=1:37
        k = 3-i+1+j-1;
        A_3(j,i) = u(k);
    end
end

% Remove first 3 points from z3
z_3 = z3(4:end);

b_3 = A_3\z_3

% Using same u, determine what b is for m = 12
z12 = filter(1,[0.05 -0.08 0.6 0.7 1 -0.2 0.3 0.6 0.4 0.4 0.2 -0.04],u);

% Create matrix A from u values for slash operation
for i=1:12
    for j=1:28
        k = 12-i+1+j-1;
        A_12(j,i) = u(k);
    end
end

% Remove first 12 points from z12
z_12 = z12(13:end);

b_12 = A_12\z_12

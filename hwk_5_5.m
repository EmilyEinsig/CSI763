clear; clc;

% Generate 1000 points using the difference equation
a = 0.1; 
b = 0.1;

z(1) = 1;
z(2) = 1;
e=randn(1000,1);

for t=3:1000
    z(t) = e(t) +a*z(t-1)+b*z(t-2);
end

% Generate A matrix for slash operation
for i=4:1000
    A(i,1) = e(i); % e column
    A(i,2) = z(i-1); % a column
    A(i,3) = z(i-2); % b column
    A(i,4) = z(i-3); % c column  
end

% Invert z matrix for slash operation
zz=z';

% Perform slash operation
p = A\zz

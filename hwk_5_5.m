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
p = A\zz;

fprintf('For a_0 = 0.1 & b_0 = 0.1,\n');
fprintf('a = %4.20f, b = %4.20f, c = %4.20f\n\n',p(2),p(3),p(4)); 


%REPEAT WITH DIFFERENT INITIAL CONDITIONS
% Generate 1000 points using the difference equation
a2 = 0.9; 
b2 = 0.1;

z2(1) = 1;
z2(2) = 1;
e2=randn(1000,1);

for t2=3:1000
    z2(t2) = e2(t2) +a2*z2(t2-1)+b2*z2(t2-2);
end

% Generate A matrix for slash operation
for i2=4:1000
    A2(i2,1) = e2(i2); % e column
    A2(i2,2) = z2(i2-1); % a column
    A2(i2,3) = z2(i2-2); % b column
    A2(i2,4) = z2(i2-3); % c column  
end

% Invert z matrix for slash operation
zz2=z2';

% Perform slash operation
p2 = A2\zz2;

fprintf('For a_0 = 0.9 & b_0 = 0.1,\n');
fprintf('a = %4.20f, b = %4.20f, c = %4.20f\n\n',p2(2),p2(3),p2(4)); 

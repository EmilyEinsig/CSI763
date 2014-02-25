clear; clc;

obs = [59 316 596 633 320 76];
exp = [62.5 312.5 625 625 312.5 62.5];

for i=1:6
   x(i) = ((obs(i)-exp(i))^2)/exp(i);
end

x2 = sum(x);

fprintf('chi-squared = %4.5f\n',x2);

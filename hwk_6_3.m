clear; clc;

b = randn(10,1);
c = [1 0 0 0 0 0 0 0 0];

z = filter(b,c,length(b));

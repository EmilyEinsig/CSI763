clear; clc;

y = [0,1,0,-1];
t = [0,1,2,3];

% Compute Raw Periodgram
N = size(t,2);
q = N/2;

for i=1:q
    for t=1:N
        a_sum(t) = y(t)*cos(2*pi*(i/N)*t);
        b_sum(t) = y(t)*sin(2*pi*(i/N)*t);
    end
    a(i) = (2/N)*sum(a_sum);
    b(i) = (2/N)*sum(b_sum);
    
    I(i) = (N/2)*(a(i)^2 + b(i)^2);
end

I

ft = fft(y)

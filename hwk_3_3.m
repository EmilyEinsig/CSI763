clear; clc;

y1 = randn(100,1);
y2 = randn(100,1);

fprintf('rand function uses a standard normal distribution, where\n');
fprintf('mu = 0, sigma = 1\n\n');

% Compute sample means
y1_m = mean(y1);
y2_m = mean(y2);

fprintf('mu(y1) = %4.5f\n',y1_m);
fprintf('mu(y2) = %4.5f\n\n',y2_m);

% Calculate the unbiased standard deviation
for i=1:size(y1,1)
    y1_diff(i) = (y1(i)-y1_m)^2;
end
y1_std = sqrt((1/(size(y1,1)-1))*sum(y1_diff));
    
for i=1:size(y2,1)
    y2_diff(i) = (y2(i)-y2_m)^2;
end
y2_std = sqrt((1/(size(y2,1)-1))*sum(y2_diff));
    
fprintf('sigma(y1) = %4.5f\n',y1_std);
fprintf('sigma(y2) = %4.5f\n\n',y2_std);
    
statD = y2_m-y1_m;
    
fprintf('Statistic D = %4.5f\n\n',statD);
    
%Compute (s_D)^2

s_D2 = 1/(size(y1,1)+size(y2,1)-2)*((size(y2,1)*y2_std^2)+(size(y1,1)*y1_std^2))

% Repeat Steps a-e 1000 times
for m=1:1000
    y1 = randn(100,1);
    y2 = randn(100,1);

    % Compute sample means
    y1_m = mean(y1);
    y2_m = mean(y2);

    % Calculate the unbiased standard deviation
    for i=1:size(y1,1)
        y1_diff(i) = (y1(i)-y1_m)^2;
    end
    y1_std = sqrt((1/(size(y1,1)-1))*sum(y1_diff));

    for i=1:size(y2,1)
        y2_diff(i) = (y2(i)-y2_m)^2;
    end
    y2_std = sqrt((1/(size(y2,1)-1))*sum(y2_diff));

    statD(m) = y2_m-y1_m;
end

num_gt2 = length(find(statD>2.0))


% Calculate area under curve for standard normal distribution where x > 2.0
syms x;

phi_prob = int(1/sqrt(2*pi)*exp(-x^2/2),2,inf); %Not sure how to get rid of the ugliness here when displayed

prob_d_gt2 = (100/2)*phi_prob

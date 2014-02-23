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

s_D2 = 1/(size(y1,1)+size(y2,1)-2)*((size(y2,1)*y2_std^2)+(size(y1,1)*y1_std^2));

fprintf('S_D^2 = %4.5f\n\n',s_D2);

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

num_gt2 = length(find(statD>2.0));

fprintf('Number of values >2.0 = %i\n\n',num_gt2);


% Calculate area under curve for standard normal distribution where x > 2.0
% erf(x) = 2/sqrt(pi) * integral from 0 to x of exp(-t^2) dt.
% To get the integral from 2 to infinity, erf(inf)-erf(2)

phi_prob = 1/(2*sqrt(2*pi))*(erf(inf)-erf(sqrt(2)));

fprintf('Probability of one value being >2.0 = %4.5f\n\n',phi_prob);

% Use Bernoulli equation to determine the probability of N/2 >2.0


prob_d_gt2 = factorial(100)/(factorial(50)*factorial(100-50))*phi_prob^(50)*(1-phi_prob)^(50);

fprintf('Probability of half of the values being >2.0 = %4.5f\n\n',prob_d_gt2);


    

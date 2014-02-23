clear; clc;

for r=1:1000
    % Generate random sample of 100 points
    Y = randn(10,1);
    
    % Calculate the standard deviations
    y_mean = mean(Y);
    for i=1:size(Y,1)
        y_diff(i) = (Y(i)-y_mean)^2;
    end
    s_b(r) = sqrt((1/(size(Y,1)))*sum(y_diff));
    s_ub(r) = sqrt((1/(size(Y,1)-1))*sum(y_diff));
    
    s_b_avg(r) = mean(s_b);
    s_ub_avg(r) = mean(s_ub);
end

% Plot histograms of average standard deviations
figure(1);
hist(s_b_avg,25);
set(get(gca,'child'),'FaceColor','none','EdgeColor','r');
hold on;
hist(s_ub_avg,25);
xlabel('Average STDEV Value');
ylabel('Number of instances');
title('Comparison of Biased and Unbiased Standard Deviations');
legend('Biased','Unbiased');

hold off;

% Calculate significance value with z-test
z = (mean(s_b_avg)-mean(s_ub_avg))/(std(s_ub_avg)/sqrt(size(s_b_avg,2)))
p = 1/(2*pi)*exp((-1*z^2)/2)

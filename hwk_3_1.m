
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

% Calculate bin size
A = sort(s_b_avg);
qtr = A(size(s_b_avg,2)/4);
size_bin = 2*qtr/(size(s_b_avg,2)^(1/3));
n_bin = (max(s_b_avg)-min(s_b_avg))/size_bin;
% Did not do this correctly; got n_bin ~1, but not sure what is wrong.

% Plot histograms of average standard deviations
figure(1);
hist(s_b_avg,25);
set(get(gca,'child'),'FaceColor','none','EdgeColor','r');
hold on;
hist(s_ub_avg,25);
xlabel('Average Stdev Value');
ylabel('Number of instances');
title('Comparison of Biased(Blue) and Ubiased(Red) Standard Deviation');

hold off;

% Calculate significance value with p-test
z = (mean(s_b_avg)-mean(s_ub_avg))/(std(s_ub_avg)/sqrt(size(s_b_avg,2)));
p = 1/(2*pi)*exp((-1*z^2)/2))

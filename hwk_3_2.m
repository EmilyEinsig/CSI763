clear; clc;

num = 5;
x = randn(num,1);

% Compute xcorr autocorrelation
[cc_x,lags] = xcorr(x,'coeff');

% Plot Lags 0 to 1 (ignore -1 lags)
figure(1);
plot(lags(num:end-1),cc_x(num:end-1),'r');
xlabel('Lags');
ylabel('Autocorrelation');
title('Comparison of xcorr & Manual Autocorrelation Functions');

% Compute full manual autocorrelation
 for k=0:size(x,1)-2
     x_m = x(k+1:size(x,1));
     x_p = x(1:size(x,1)-k);
     x_m = x_m-mean(x_m);
     x_p = x_p-mean(x_p);
     ttop = sum(x_m.*x_p);
     x_mm = mean(x_m);
     x_pm = mean(x_p);
     bottom1 = sum((x_m-x_mm).^2);
     bottom2 = sum((x_p-x_pm).^2);
    tbottom = sqrt(bottom1*bottom2);
     cc(k+1) = ttop/tbottom;
 end
 

 c_lag=(0:num-2);

 hold on;
 plot(c_lag,cc);
 legend('xcorr','Manual','Manual-Shortcut'); 
 hold off;

clear; clc;

xx = randn(2,1);

% Compute xcorr autocorrelation
[c_xx,lags] = xcorr(xx,'coeff');

% Plot Lags 0 to 1 (ignore -1 lags)
figure(1);
plot(lags(2:3),c_xx(2:3),'r');
xlabel('Lags');
ylabel('Autocorrelation');
title('Comparison of xcorr(red) & Manual(blue) Autocorrelation');

% Compute manual autocorrelation

 top = 0;
 bottom1 = 0;
 bottom2 = 0;
 for k=0:1
     for i=1:(size(xx,1)-1)
         x_m = mean(xx(i+1:size(xx,1)));
         x_p = mean(xx(1:size(xx,1))-(i-1));
         top = top+(xx(i)-x_m)*(xx(i+1)-x_p);
         bottom1 = bottom1+(xx(i+k)-x_m)^2;
         bottom2 = bottom2+(xx(i+1)-x_p)^2;
         bottom = sqrt(bottom1*bottom2);
         cc(k+1) = top/bottom;
     end
 end
 
 % Manual gives me the negative of what I expect (e.g., cc(0)=-1).
 cc(1) = -1*cc(1); % Manually adjusted.
 c_lag=[0 1];

 hold on;
 plot(c_lag,cc);

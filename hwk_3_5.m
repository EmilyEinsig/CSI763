clear; clc;

fid2 = fopen('A1.txt');
% Column header [     Ithaca------------------   Canandaigua-------------]
% Column header [date precip max_temp min_temp   precip max_temp min_temp LineEnd:100]
B = fscanf(fid2, '%i %f %i %i %f %i %i %s', [1 inf]);
fclose(fid2);

B=B';

% % Find average temperature values for both locations
% ind_end = find(B=='Y');
% 
% % Calculate avgerage for each date
% ith_t_avg = (B(ind_end-5)-B(ind_end-4))/2+B(ind_end-4);
% can_t_avg = (B(ind_end-2)-B(ind_end-1))/2+B(ind_end-1);
% 
% ith_AVG = mean(ith_t_avg);
% can_AVG = mean(can_t_avg);
% 
% % Use t test to calculate standard deviation
% % Calculate s_ithaca^2 and s_can^2
% s_i2 = sum((ith_t_avg-ith_AVG).^2);
% s_c2 = sum((can_t_avg-can_AVG).^2);
% 
% mm=31; nn=31;
% 
% t2 = -1*(ith_AVG - can_AVG)/sqrt(s_i2/(mm*(mm-1))+s_c2/(nn*(nn-1)))
% 
% % Draw a gaussian (i.e., normal) distribution with sample mean and t2
% % standard deviation
% x=[0:50];
% pdi = normpdf(x,ith_AVG,t2);
% pdc = normpdf(x,can_AVG,t2);
% 
% figure(1);
% plot(pdi,'r');
% hold on;
% plot(pdc,'b');
% 
% xlabel('Average Temperature');
% ylabel('Probability');
% title('Normal Probabilty Distribution Function: Ithaca(Red), Canandaigua(Blue)');
% hold off;

% Find minimum temperature values for both locations
ind_end = find(B=='Y');

% Calculate avgerage for each date
ith_t_min = B(ind_end-4);
can_t_min = B(ind_end-1);

ith_min_AVG = mean(ith_t_min);
can_min_AVG = mean(can_t_min);

% Use t test to calculate standard deviation
% Calculate s_ithaca^2 and s_can^2
s_im2 = sum((ith_t_min-ith_min_AVG).^2);
s_cm2 = sum((can_t_min-can_min_AVG).^2);

mm=31; nn=31;

t22 = -1*(ith_min_AVG - can_min_AVG)/sqrt(s_im2/(mm*(mm-1))+s_cm2/(nn*(nn-1)));

% Draw a gaussian (i.e., normal) distribution with sample mean and t2
% standard deviation
x2=[0:50];
pdi2 = normpdf(x2,ith_min_AVG,t22);
pdc2 = normpdf(x2,can_min_AVG,t22);

figure(2);
plot(pdi2,'r');
hold on;
plot(pdc2,'b');

yL = get(gca,'YLim');
zz=17.6;
line([zz zz],yL,'Color','g');

xlabel('Minimum Temperature');
ylabel('Probability');
title('Normal Probabilty Distribution Function: Ithaca(Red), Canandaigua(Blue)');
hold off;

% Calculate p value for null hypothesis
syms x;

pc_value = int(1/(t22*sqrt(2*pi))*exp(-(x-can_min_AVG)^2/(2*t22^2)),-inf,zz); %Not sure how to get rid of the ugliness here when displayed
pi_value = int(1/(t22*sqrt(2*pi))*exp(-(x-ith_min_AVG)^2/(2*t22^2)),zz,inf); %Not sure how to get rid of the ugliness here when displayed

p_value = pc_value+pi_value

clear; clc;

fid = fopen('A3.txt');
% Column header [year temp precip pressue Nino:Y/N]
A = fscanf(fid, '%i %f %f %f %s', [1 inf]);
fclose(fid);

A=A';

% Perform two-sample t test for June temperatures
% Find average temperature values for Nino and Clear years
ind_n = find(A=='Y');
n_t_avg = sum(A(ind_n-3))/size(ind_n,1);

ind_c = find(A=='N');
c_t_avg = sum(A(ind_c-3))/size(ind_c,1);

% Calculate s_nino^2 and s_clear^2
s_n2 = sum((A(ind_n-3)-n_t_avg).^2);
s_c2 = sum((A(ind_c-3)-c_t_avg).^2);

mm=20; nn=20;

t2 = (n_t_avg - c_t_avg)/sqrt(s_n2/(mm*(mm-1))+s_c2/(nn*(nn-1)));

% Draw a gaussian (i.e., normal) distribution with sample mean and t2
% standard deviation
x=[0:100];
s_avg = 24.76;
pd = normpdf(x,s_avg,t2);

figure(1);
plot(pd);
hold on;

yL = get(gca,'YLim');
line([n_t_avg n_t_avg],yL,'Color','r');
line([c_t_avg c_t_avg],yL,'Color','g');

xlabel('Temperature');
ylabel('Probability');
title('Normal Probabilty Distribution Function: Nino average(Red), Clear average(Green) ');

% Find 95% confidence

xt = norminv(0.95,s_avg,t2);

fprintf('Minimum difference in mean temperatures (0.95 confidence) is %4.3f degrees\n',abs(s_avg-xt));
fprintf('Current difference in mean temperatures is %4.3f degrees\n',abs(c_t_avg-n_t_avg));

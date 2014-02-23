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

nn=size(ind_n,1); 
cc=size(ind_c,1);

t2 = (n_t_avg - c_t_avg)/sqrt(s_n2/(nn*(nn-1))+s_c2/(cc*(cc-1)));

fprintf('t value = %4.5f\n',t2);

% Find 95% confidence
t_exp = 2.7764;
tdiff = sqrt(s_n2/(nn*(nn-1))+s_c2/(cc*(cc-1)))*t_exp;

fprintf('Minimum difference in mean temperatures (0.95 confidence) is %4.3f degrees\n',abs(tdiff));
fprintf('Current difference in mean temperatures is %4.3f degrees\n',abs(c_t_avg-n_t_avg));



clear; clc;

fid2 = fopen('A1.txt');
% Column header [     Ithaca------------------   Canandaigua-------------]
% Column header [date precip max_temp min_temp   precip max_temp min_temp LineEnd:100]
B = fscanf(fid2, '%i %f %i %i %f %i %i %s', [1 inf]);
fclose(fid2);

B=B';

% Perform two-sample t test for June temperatures
% Find average minimum temperature values for Ithaca and Canandaigua
ind_end = find(B=='Y');

ith_min = B(ind_end-4);
ith_min_AVG = mean(ith_min);

can_min = B(ind_end-1);
can_min_AVG = mean(can_min);

% Calculate s_ithaca^2 and s_can^2
s_i2 = sum((ith_min-ith_min_AVG).^2);
s_c2 = sum((can_min-can_min_AVG).^2);

ii=31; 
cc=31;

t2 = (can_min_AVG - ith_min_AVG)/sqrt(s_c2/(cc*(cc-1))+s_i2/(ii*(ii-1)));

fprintf('t value = %4.5f\n',t2);

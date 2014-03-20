clear; clc;

load('OMNI_OMNI2_merged_20130927-v1.mat');

% Calculate tau values from data
for i=2:size(Plasma_bulk_speed,1)
    E(i) = Plasma_bulk_speed(i)*(abs(Bz_GSM(i))-Bz_GSM(i))/2;
    tau(i-1) = Dst_index(i)/(E(i) - Dst_index(i) + Dst_index(i-1));
end

tau=tau';

num_nan = sum(isnan(tau) == 1)

num_inf = sum(isinf(tau) == 1)

tau(isnan(tau))= [];

tau(isinf(tau))= [];

figure();
hist(tau,60);
xlabel('Tau Value');
ylabel('Number of values');

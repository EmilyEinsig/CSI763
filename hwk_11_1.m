%CODE AND EXAMPLE ADAPTED FROM http://studentdavestutorials.weebly.com/kalman-filter-with-matlab-code.html

clear; clc;

t_max = 10; % in minutes
dt = .1;  %time sample interval

% Define coefficent matrices
A = [1 dt; 0 1]; 
B = [dt^2/2; dt];
C = [1 0];

% Define variables
u = 1.5; %acceleration magnitude
Plane = [0; 0]; %initized state p,v state of plane
Plane_estimate = Plane;  %initialize x_t
P_noise_mag = 0.05; %plane position noise (i.e. stdev in plane's acceleration)
Obs_noise_mag = 10;  %measurement noise (i.e. stdev of position estimate)
Ez = Obs_noise_mag^2;%Convert the measurement noise into covariance matrix
Ex = P_noise_mag^2 * [dt^4/4 dt^3/2; dt^3/2 dt^2]; %Convert the position noise into covariance matrix
P_cov = Ex; %estimate of initial plane position variance (covariance matrix)

% initize result variables
P_loc = []; % ACTUAL plane flight path
vel = []; % ACTUAL plane velocity
P_loc_meas = []; % Plane path that the observer sees


% simulate what the observer sees over time
for t = 0 : dt: t_max
    % Generate the plane flight
    P_noise = P_noise_mag * [(dt^2/2)*randn; dt*randn];
    Plane= A * Plane+ B * u + P_noise;
    % Generate what the observer sees
    Obs_noise = Obs_noise_mag * randn;
    y = C * Plane+ Obs_noise;
    P_loc = [P_loc; Plane(1)];
    P_loc_meas = [P_loc_meas; y];
    vel = [vel; Plane(2)];
end

% Do kalman filtering
%initize estimation variables
P_loc_estimate = []; %  Plane position estimate
vel_estimate = []; % Plane velocity estimate
Plane= [0; 0]; % re-initized state
P_cov_estimate = P_cov;
P_cov_mag_estimate = [];
predic_state = [];
predic_var = [];
for t = 1:length(P_loc)
    % Predict next state of the plane with the last state and predicted motion.
    Plane_estimate = A * Plane_estimate + B * u;
    predic_state = [predic_state; Plane_estimate(1)] ;
    %predict next covariance
    P_cov = A * P_cov * A' + Ex;
    predic_var = [predic_var; P_cov] ;
    % predicted observer measurement covariance
    % Kalman Gain
    K = P_cov*C'*inv(C*P_cov*C'+Ez);
    % Update the state estimate.
    Plane_estimate = Plane_estimate + K * (P_loc_meas(t) - C * Plane_estimate);
    % update covariance estimation.
    P_cov =  (eye(2)-K*C)*P_cov;
    %Store for plotting
    P_loc_estimate = [P_loc_estimate; Plane_estimate(1)];
    vel_estimate = [vel_estimate; Plane_estimate(2)];
    P_cov_mag_estimate = [P_cov_mag_estimate; P_cov(1)];
end

% Plot the results
figure(1);
tt = 0 : dt : t_max;
plot(tt,P_loc,'-r.',tt,P_loc_meas,'-k.', tt,P_loc_estimate,'-g.');
axis([0 10 -30 80])
title('Actual, Observed, and Kalman Filtered Track Comparison');
xlabel('Time (minutes)');
ylabel('Position (m)');
legend('Actual Plane location','Observed Plane Location', 'Kalman Filtered Plane Location');
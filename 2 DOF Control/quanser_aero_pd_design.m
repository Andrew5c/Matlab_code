% Load model parameters
quanser_aero_parameters;
% 
%% Control Specifications
% Peak time and overshoot specifications
PO = 7.5;
tp = 1.75;
% Damping ratio from overshoot specification.
zeta = -log(PO/100) * sqrt( 1 / ( ( log(PO/100) )^2 + pi^2 ) );
% Natural frequency from specifications (rad/s)
wn = pi / ( tp * sqrt(1-zeta^2) );
%
%% Pitch PV Design
% Set DC gain and time constant for pitch axis
K = Kpp/Dp;
tau = Jp/Dp;
% Proportional gain (V/rad)
kp_p = tau*wn^2/K;
% Deriveative/velocity gain (V-s/rad)
kd_p = (2*tau*zeta*wn-1)/K;
%
%% Yaw PV Design
% Set DC gain and time constant for yaw axis
K = Kyy/Dy;
tau = Jy/Dy;
% Proportional gain (V/rad)
kp_y = tau*wn^2/K;
% Deriveative/velocity gain (V-s/rad)
kd_y = (2*tau*zeta*wn-1)/K;
% 
%% Display
kp_p
kd_p
kp_y
kd_y
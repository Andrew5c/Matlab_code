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
% Proportional gain (V/rad)
kp_p = (Jp*wn^2-Ksp)/Kpp;
% Deriveative/velocity gain (V-s/rad)
kd_p = (2*zeta*wn*Jp-Dp)/Kpp;
%
%% Yaw PV Design
% Proportional gain (V/rad)
kp_y = Jy*wn^2/Kyy;
% Deriveative/velocity gain (V-s/rad)
kd_y = (2*Jy*zeta*wn-Dy)/Kyy;
% 
%% Display
kp_p
kd_p
kp_y
kd_y
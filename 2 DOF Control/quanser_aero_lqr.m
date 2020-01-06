% Load model parameters
quanser_aero_parameters;
% Load state-space matrices 
quanser_aero_state_space;
% 
%% State-Feedback LQR Control Design
% Q = diag([150 75 0 0 ]);
Q = diag([200 75 0 0 ]);
R = 0.005*eye(2, 2);
K = lqr(A,B,Q,R)


%% use the off-line algorithm of the optimal course
% Q = diag([200 75 0 0 ]);
% R = 0.005*eye(2,2);
% 
% K_0 = [90 -100   30  -30;
%        150   60   45   15];
% A_0 = A - B * K_0; 
% 
% H = -Q - (K_0)' * R * K_0;
% P_0 = sylvester((A_0)',A_0,H);
% 
% i = 1;
% KK = R\B' * P_0;
% AA = A - B * KK;
% HH = -Q - KK' * R * KK;
% PP = sylvester(AA',AA,HH);
% 
% error = norm(PP-P_0);
% F(:,i) = error;
% 
% while error>0.01
%     i = i+1;
%     P_0 = PP;
% 
%     KK = R\B'*P_0;
%     AA = A-B*KK;
%     HH = -Q-KK'*R*KK;
%     PP = sylvester(AA',AA,HH);
%     error = norm(PP-P_0);
%     F(:,i) = error;
% end
% K = R\B'*PP ;





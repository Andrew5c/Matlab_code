% ==============================
% This file used for calculate the matries L and M
% ==============================

global L1 L2 L3 L4 M1 M2 M3 M4
global gamma

 
% define the matrix of leader
s1 = [0 1;-1 0]; s2 = [0 2;-2 0]; s3 = [0 0;0 0];
S = blkdiag(s1,s2,s3);
H = eye(6);
H1 = H(1:2,:); H2 = H(3,:); H3 = H(4,:); H4 = H(5:6,:);

% we use the same communication graph as 2019 TAC : 4 nodes
% Laplacian matrix of the network,also same as the 2019 TAC
L = [2 -1 0 -1;
     0 1 -1 0;
     -1 -1 2 0;
     -1 0 0 1];
% adjacency matrix of the network
adj_matrix = [0 0 1 1;
              1 0 1 0;
              0 1 0 0;
              1 0 0 0];
% coupling gain, should be sufficiently large
gamma = 220;
% decay rate
alpha = 1;
% the normalized positive left vecter
r = [0.8 1.6 0.8 0.8];

% ===============================
% Using traditional methods
% calculate the nonsingular matrix T first : use the "O=obsv(A,C)",and take 
% the first "rank(obsv(A,C))" row of O,
% A_obs=T*A*inv(T), C_obs=C*inv(T)
% then take the inverse of the matrix T
% ================================
A1_obs = [0 1;-1 0];
H1_obs = [1 0;0 1];
T1 = eye(6,6);
T1 = inv(T1);
% ----------------------
A2_obs = [0 1;-4 0];
H2_obs = [1 0];
T2 = [0 0 1 0 0 0;
      0 0 0 2 0 0;
      1 0 0 0 0 0;
      0 1 0 0 0 0;
      0 0 0 0 1 0;
      0 0 0 0 0 1];
T2 = inv(T2);
% -----------------------
A3_obs = [0 1;-4 0];
H3_obs = [1 0];
T3 = [0 0 0 1 0 0;
      0 0 -2 0 0 0;
      1 0 0 0 0 0;
      0 1 0 0 0 0;
      0 0 0 0 1 0;
      0 0 0 0 0 1];
T3 = inv(T3);
% ----------------------
A4_obs = [0 0;0 0];
H4_obs = [1 0;0 1];
T4 = [0 0 0 0 1 0;
      0 0 0 0 0 1;
      1 0 0 0 0 0;
      0 1 0 0 0 0;
      0 0 1 0 0 0;
      0 0 0 1 0 0];
T4 = inv(T4);

% choose the poles to be placed
% p1 = [-1.3+2i,-1.3-2i];
% p2 = [-1.5+3i,-1.5-3i];
% p3 = [-1.8+4i,-1.8-4i];
% p4 = [-2+5i,-2-5i];
p1 = [-1.2,-1.4];
p2 = [-1.6,-1.8];
p3 = [-2.1,-2.8];
p4 = [-3.0,-3.4];
L1_T = place(A1_obs', H1_obs', p1); L1_obs = L1_T';
L2_T = place(A2_obs', H2_obs', p2); L2_obs = L2_T';
L3_T = place(A3_obs', H3_obs', p3); L3_obs = L3_T';
L4_T = place(A4_obs', H4_obs', p4); L4_obs = L4_T';

% solve the Lyapunov equation for every node
sylves_A1 = A1_obs - L1_obs*H1_obs + alpha*eye(2);
sylves_C1 = (2*alpha - gamma/r(1))*eye(2);
P1_obs = sylvester(sylves_A1', sylves_A1, sylves_C1);

sylves_A2 = A2_obs - L2_obs*H2_obs + alpha*eye(2);
sylves_C2 = (2*alpha - gamma/r(2))*eye(2);
P2_obs = sylvester(sylves_A2', sylves_A2, sylves_C2);

sylves_A3 = A3_obs - L3_obs*H3_obs + alpha*eye(2);
sylves_C3 = (2*alpha - gamma/r(3))*eye(2);
P3_obs = sylvester(sylves_A3', sylves_A3, sylves_C3);

sylves_A4 = A4_obs - L4_obs*H4_obs + alpha*eye(2);
sylves_C4 = (2*alpha - gamma/r(4))*eye(2);
P4_obs = sylvester(sylves_A4', sylves_A4, sylves_C4);

% compute the matrix L_i and M_i
[m,n] = size(L1_obs);
L1 = T1*[L1_obs;zeros(6-m,n)];
M1 = T1*[inv(P1_obs) zeros(2,4);zeros(4,2) eye(4)]*(T1');

[m,n] = size(L2_obs);
L2 = T2*[L2_obs;zeros(6-m,n)];
M2 = T2*[inv(P2_obs) zeros(2,4);zeros(4,2) eye(4)]*(T2');

[m,n] = size(L3_obs);
L3 = T3*[L3_obs;zeros(6-m,n)];
M3 = T3*[inv(P3_obs) zeros(2,4);zeros(4,2) eye(4)]*(T3');

[m,n] = size(L4_obs);
L4 = T4*[L4_obs;zeros(6-m,n)];
M4 = T4*[inv(P4_obs) zeros(2,4);zeros(4,2) eye(4)]*(T4');


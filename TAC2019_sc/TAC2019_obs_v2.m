function dydt = TAC2019_obs_v2(t, x)
% ----------------------------------
% date: 2020.2.4
% author: Shuai Qian
% describe: simulation for the 2019 TAC
% ---------------------------------

global L1 L2 L3 L4 M1 M2 M3 M4
global gamma

% states of the observerd system
v = x(1:6);
% states of the 4 observers
x_obs1 = x(7:12); x_obs2 = x(13:18); x_obs3 = x(19:24); x_obs4 = x(25:30);
% follower states
x_follow1 = x(31:34);
% observer state of plant states
x_follow1_hat = x(35:38); 
% internal model states
z = x(39:44);  

% leader
s1 = [0 1;-1 0]; s2 = [0 2;-2 0]; s3 = [0 0;0 0];
S = blkdiag(s1,s2,s3);
H = eye(6);
H1 = H(1:2,:); H2 = H(3,:); H3 = H(4,:); H4 = H(5:6,:);
% input of every observer
y_obs1 = H1*v; y_obs2 = H2*v; y_obs3 = H3*v; y_obs4 = H4*v;

% we use the same communication graph as 2019 TAC : 4 nodes
% Laplacian matrix of the network
L = [2 -1 0 -1;
     0 1 -1 0;
     -1 -1 2 0;
     -1 0 0 1];
% adjacency matrix of the network
adj_matrix = [0 0 1 1;
              1 0 1 0;
              0 1 0 0;
              1 0 0 0];
          
% ==========================================
% followers
A = [0 0 1 0;
    0 0 0 1;
    -1.7117 0 -0.3249 0;
    0 0 0 -1.0004];
B = [0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1];
C = [1 0 0 0;0 1 0 0];

% disterbance and reference signal
F = [-1 0 0 0 0 0;0 0 0 0 0 0];

% the first internal model
G11 = [0 1 0;0 0 1;0 -1 0];
G12 = [0;0;1];
% the second
G21 = G11;
G22 = G12;
% augmented internal model,for stabilizating design
G1 = [G11 zeros(3,3);zeros(3,3) G21];
G2 = [G12 zeros(3,1);zeros(3,1) G22];

% the augmented system matrix, Ac:10x10, Bc:10x2
Ac = [A zeros(4,6);G2*C G1];
Bc = [B;zeros(6,2)];

% the poles you want to place
P1 = [-1.1+1i -1.1-1i -2+2i -2-2i -3+3i -3-3i -4+4i -4-4i -5+5i -5-5i];
% the whole feedback gain
K = place(Ac, Bc, P1);
K1 = K(1:2, 1:4);
K2 = K(1:2, 5:10);
% design the observer gain
P2 = [-5+1i -5-1i -1+4i -1-4i];
% (A-LC) Hurwitz
L = place(A', C', P2);
L = L';
% regulated output
e = C*x_follow1 + F*x_obs1;
% controler
u = -K1*x_follow1_hat - K2*z;


% dynamic equations
% ======================================
dydt = zeros(44,1);
% dynamic of the observered system
dydt(1:6) = S*v;
% dynamic of the 4 observers
dydt(7:12) = S*x_obs1 + L1*(y_obs1-H1*x_obs1) + gamma*M1*(adj_matrix(1,1)*(x_obs1-x_obs1)+...
    adj_matrix(1,2)*(x_obs2-x_obs1)+adj_matrix(1,3)*(x_obs3-x_obs1)+adj_matrix(1,4)*(x_obs4-x_obs1));
dydt(13:18) = S*x_obs2 + L2*(y_obs2-H2*x_obs2) + gamma*M2*(adj_matrix(2,1)*(x_obs1-x_obs2)+...
    adj_matrix(2,2)*(x_obs2-x_obs2)+adj_matrix(2,3)*(x_obs3-x_obs2)+adj_matrix(2,4)*(x_obs4-x_obs2));
dydt(19:24) = S*x_obs3 + L3*(y_obs3-H3*x_obs3) + gamma*M3*(adj_matrix(3,1)*(x_obs1-x_obs3)+...
    adj_matrix(3,2)*(x_obs2-x_obs3)+adj_matrix(3,3)*(x_obs3-x_obs3)+adj_matrix(3,4)*(x_obs4-x_obs3));
dydt(25:30) = S*x_obs4 + L4*(y_obs4-H4*x_obs4) + gamma*M4*(adj_matrix(4,1)*(x_obs1-x_obs4)+...
    adj_matrix(4,2)*(x_obs2-x_obs4)+adj_matrix(4,3)*(x_obs3-x_obs4)+adj_matrix(4,4)*(x_obs4-x_obs4));
% plant dynamics 
dydt(31:34) = A*x_follow1 + B*u;
% the observer dynamics
dydt(35:38) = (A-L*C)*x_follow1_hat + B*u + L*e;
% the p-copy internal model
dydt(39:44) = G1*z + G2*e;


end


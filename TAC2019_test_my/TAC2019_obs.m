function dydt = TAC2019_obs(t, x)
% ----------------------------------
% date: 2020.2.4
% author: Shuai Qian
% describe: simulation for the 2019 TAC
% ---------------------------------

global L1 L2 L3 L4 M1 M2 M3 M4
global gamma

% state of the observerd system
v = x(1:6);
% state of the 4 observers
x1 = x(7:12); x2 = x(13:18); x3 = x(19:24); x4 = x(25:30);

% define the matrix of leader
s1 = [0 1;-1 0]; s2 = [0 2;-2 0]; %s3 = [0 3;-3 0];
s3 = [0 0;0 0];
S = blkdiag(s1,s2,s3);
H = eye(6);
H1 = H(1:2,:); H2 = H(3,:); H3 = H(4,:); H4 = H(5:6,:);
% input of every observer
y1 = H1*v; y2 = H2*v; y3 = H3*v; y4 = H4*v;

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

% dynamic equations
% ======================================
dydt = zeros(30,1);
% dynamic of the observered system
dydt(1:6) = S*v;
% dynamic of the 4 observers
dydt(7:12) = S*x1 + L1*(y1-H1*x1) + gamma*M1*(adj_matrix(1,1)*(x1-x1)+adj_matrix(1,2)*(x2-x1)+adj_matrix(1,3)*(x3-x1)+adj_matrix(1,4)*(x4-x1));
dydt(13:18) = S*x2 + L2*(y2-H2*x2) + gamma*M2*(adj_matrix(2,1)*(x1-x2)+adj_matrix(2,2)*(x2-x2)+adj_matrix(2,3)*(x3-x2)+adj_matrix(2,4)*(x4-x2));
dydt(19:24) = S*x3 + L3*(y3-H3*x3) + gamma*M3*(adj_matrix(3,1)*(x1-x3)+adj_matrix(3,2)*(x2-x3)+adj_matrix(3,3)*(x3-x3)+adj_matrix(3,4)*(x4-x3));
dydt(25:30) = S*x4 + L4*(y4-H4*x4) + gamma*M4*(adj_matrix(4,1)*(x1-x4)+adj_matrix(4,2)*(x2-x4)+adj_matrix(4,3)*(x3-x4)+adj_matrix(4,4)*(x4-x4));

end


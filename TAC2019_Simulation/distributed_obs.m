function dydt = distributed_obs(t, x)
% ----------------------------------
% date: 2020.2.2
% author: Shuai Qian
% describe: simulation for the 2019 TAC : A Simple Approach to 
% Distributed Observer Design for Linear Systems
% ---------------------------------

global L1 L2 L3 L4 M1 M2 M3 M4
global gamma

% state of the observerd system
v = x(1:6);
% state of the 4 observers
x1 = x(7:12);
x2 = x(13:18);
x3 = x(19:24);
x4 = x(25:30);

% system matrix of the observerd system 
A = [-1 0 0 0 0 0;
     -1 1 1 0 0 0;
     1 -2 -1 -1 1 1;
     0 0 0 -1 0 0;
     -8 1 -1 -1 -2 0;
     4 -0.5 0.5 0 0 -4];
H = [1 0 0 2 0 0;
     2 0 0 1 0 0;
     2 0 1 0 0 1;
     0 0 0 2 0 0;
     1 0 2 0 0 0;
     2 0 4 0 0 0];
H1 = H(1:2,:);
H2 = H(3,:);
H3 = H(4,:);
H4 = H(5:6,:);

% input of every observer
y1 = H1*v;
y2 = H2*v;
y3 = H3*v;
y4 = H4*v;
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
          
% the following data is copy form paper directly
% ====================================================
% L1 = [0.1661 0.1661;0 0;0 0;0.4982 -0.4982;0 0;0 0];
% L2 = [3.5770;-14.3468;0.5188;-5.4729;-14.8217;-5.9758];
% L3 = zeros(6,1);
% L4 = [-2.2551 0.3970;-8.9847 -2.6908;1.6216 0.1859;
%       6.2723 0.9189;-3.0056 -1.7857;15.9378 -1.8280];
%   
% M1 = diag([0.0037,1,1,0.0037,1,1]);
% M2 = [0.0512 0.0879 -0.1315 -0.1416 -0.0429 0.0297;
%       0.0879 0.1796 -0.2330 -0.2519 -0.0576 0.0528;
%       -0.1315 -0.2330 0.3450 0.3644 0.1031 -0.0822;
%       -0.1416 -0.2519 0.3644 0.3981 0.1173 -0.0816;
%       -0.0429 -0.0576 0.1031 0.1173 0.0549 -0.0216;
%       0.0297 0.0528 -0.0822 -0.0816 -0.0216 0.0259];
% M3 = diag([1,1,1,0.0130,1,1]);
% M4 = [0.0390 0.0293 -0.0195 -0.1186 -0.1410 0.0409;
%       0.0293 0.0315 -0.0161 -0.0932 -0.1002 0.0303;
%       -0.0195 -0.0161 0.0103 0.0598 0.0696 -0.0210;
%       -0.1186 -0.0932 0.0598 0.3643 0.4299 -0.1273;
%       -0.1410 -0.1002 0.0696 0.4299 0.5260 -0.1603;
%       0.0409 0.0303 -0.0210 -0.1273 -0.1603 0.0621];

% ======================================
dydt = zeros(30,1);
% dynamic of the observered system
dydt(1:6) = A*v;
% dynamic of the 4 observers
dydt(7:12) = A*x1 + L1*(y1-H1*x1) + gamma*M1*(adj_matrix(1,1)*(x1-x1)+adj_matrix(1,2)*(x2-x1)+adj_matrix(1,3)*(x3-x1)+adj_matrix(1,4)*(x4-x1));
dydt(13:18) = A*x2 + L2*(y2-H2*x2) + gamma*M2*(adj_matrix(2,1)*(x1-x2)+adj_matrix(2,2)*(x2-x2)+adj_matrix(2,3)*(x3-x2)+adj_matrix(2,4)*(x4-x2));
dydt(19:24) = A*x3 + L3*(y3-H3*x3) + gamma*M3*(adj_matrix(3,1)*(x1-x3)+adj_matrix(3,2)*(x2-x3)+adj_matrix(3,3)*(x3-x3)+adj_matrix(3,4)*(x4-x3));
dydt(25:30) = A*x4 + L4*(y4-H4*x4) + gamma*M4*(adj_matrix(4,1)*(x1-x4)+adj_matrix(4,2)*(x2-x4)+adj_matrix(4,3)*(x3-x4)+adj_matrix(4,4)*(x4-x4));

end



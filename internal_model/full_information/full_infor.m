function dydt=full_infor(t,y)

x = y(1:2);
w = y(3:4);


A = [0 1;0 0];
B = [0;1];
C = [1 0];

S = [0 1;-1 0];
P = [1 0;0 0];
Q = [-1 0];

% solve the regulator equation
% from the steady state variable perspective
PI = [1 0;-1 1];
TAU = [-1 -1];

% the regulat output
e = C*x + Q*w;

% place the poles for the stabilization
P1 = [-5+1i -5-1i];
K = place(A, B, P1);
% the feedforward gain
E = TAU + K*PI;

u = -K*x + E*w;

dydt = zeros(4,1);

dydt(1:2) = A*x + B*u + P*w;
dydt(3:4) = S*w;

end

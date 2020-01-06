function dxdt = originSYS(t, x)

stateX = [x(1); x(2)];
stateX_hat = [x(3); x(4)];

A = [0 1; 20.6 0];
B = [0; 1];
C = [1 0];
Pc = [-1.8+2.4i -1.8-2.4i];

% config the special pole
K = place(A, B, Pc);
% give the state feedback control law


% bulid the full order state observer
Atue = A';
Btue = C';
Q = [Btue, Atue*Btue];
Po = [-8 0; 0 -8];
phi = polyvalm(poly(Po), Atue);
Ke = [0 1]*inv(Q)*phi;
% Ke = place(Atue, Btue, Po);
L = Ke';

u = -K*stateX_hat;

dxdt = zeros(4,1);

dxdt(1:2) = A*stateX + B*u;

dxdt(3:4) = A*stateX_hat + B*u + L*(C*stateX - C*stateX_hat);

end
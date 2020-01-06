function dy = canonical(t,y)

x=y(1:4);
v=y(5:7);
eta=y(8:13);
x_hat=y(14:17); % observer state of plant state

A=[0 0 1 0;
   0 0 0 1;
   -1.7117 0 -0.3249 0;
   0 0 0 -1.0004];
B=[0 0;
   0 0;
   0.0503 0.0959;
   -0.1228 0.1];
C=[1 0 0 0;0 1 0 0];

% exosystem
S=[0 1 0;-1 0 0;0 0 0];
E=[0 0 0;0 0 0;0 0 0;0 0 1];
F=[-1 0 0;0 0 0];

% regulated output
e = C*x + F*v;

% the canonical internal model
M1=[0 1 0;
    0 0 1'
    -1 -2 -3];
N1=[0;0;1];

M2 = M1;
N2 = N1;

M = [M1 zeros(3,3);zeros(3,3) M2];
N = [N1 zeros(3,1);zeros(3,1) N2];

% solve the regulator equation
% phi = -C\F;
% tau = B\(phi*S - A*phi - E);

% transform the steady state Uss to the minimal realization form
PSI1 = [0 1 0;0 0 1;0 -1 0];
PHI1 = [1 0 0];

PSI2 = PSI1;
PHI2 = PHI1;

PSI = [PSI1 zeros(3,3);zeros(3,3) PSI2];
PHI = [PHI1 zeros(1,3);zeros(1,3) PHI2];

% solve the sylvester equation
SIGMA = sylvester(-M, PSI, N*PHI);
% the controller for compensate exosystem
Uss = PHI*inv(SIGMA)*eta;
 
% the controller for stabilization
% why the poles must be in pairs?
P1 = [-4+1i -4-1i -10+4i -10-4i];
K = place(A, B, P1);
% the observer state x_hat is the system error
Utue = -K*x_hat;

% the composite controller
U = Utue + Uss;

% design the observer gain
P2 = [-20+1i -20-1i -15+4i -15-4i];
% (A-LC) Hurwitz
L = place(A', C', P2);
L = L';

dy = zeros(17,1);
% plant
dy(1:4) = A*x + B*U + E*v;
% exosystem
dy(5:7) = S*v;
% canonical internal model
dy(8:13) = M*eta + N*U;
% the observer dynamics
dy(14:17) = (A-L*C)*x_hat + B*Utue + L*e;

end


function dy = Pcopy(t,y)

x=y(1:4);   % plant state
v=y(5:7);   % exosystem state
z=y(8:13);  % internal model state
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

% exosystem : v1=sin(t), v2=cos(t), v3=v3(0)
S=[0 1 0;-1 0 0;0 0 0];

% disterbance and reference signal
E=[0 0 1;0 0 2;0 0 0;1 1 1];
F=[-1 0 0;0 0 0];

% design two p-copy internal models,because we have two input
% (G1,G2) should be controllable, and G1 should include the eigenvalue of
% the exosystem, simplely,G1=S
% or, G1 take the controllable canonical form

% the first internal model
G11=[0 1 0;0 0 1;0 -1 0];
G12=[0;0;1];
% the second
G21=G11;
G22=G12;
% augmented internal model,for stabilizating design
G1 = [G11 zeros(3,3);zeros(3,3) G21];
G2 = [G12 zeros(3,1);zeros(3,1) G22];

% the augmented system matrix, Ac is 10-dim matrix
Ac = [A zeros(4,6);G2*C G1];
Bc = [B;zeros(6,2)];
% the poles you want to place
P1 = [-1+1i -1-1i -2+2i -2-2i -3+3i -3-3i -4+4i -4-4i -5+5i -5-5i];
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
e = C*x + F*v;      
% controler
u = -K1*x_hat - K2*z;


dy = zeros(17, 1);
% plant dynamics, only the last equation add the uncertainty:w 
dy(1:4) = A*x + B*u + E*v;
% exosystem, produce sin reference signal, and constant parameter uncertainty
dy(5:7) = S*v;
% the p-copy internal model
dy(8:13) = G1*z + G2*e;
% the observer dynamics
dy(14:17) = (A-L*C)*x_hat + B*u + L*e;

end


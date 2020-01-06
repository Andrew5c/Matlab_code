function dx = TwoDOF_CIM(t,x)
global Psi T miu_k k
k = k+1;
a1 = -1.7;
a2 = -0.3;
b1 = 0.05;
b2 = 0.09;
a3 = -1;
b3 = -0.1;
b4 = 0.1;
%% Parameters:
x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
w = x(5:7);
eta1 = x(8:10);
eta2 = x(11:13);
x_hat = x(14:17);

A = [0 0 1 0;0 0 0 1;a1 0 a2 0;0 0 0 a3];
B = [0 0;0 0;b1 b2;b3 b4];
C = [1 0 0 0;0 1 0 0];

P1 = [-2+1i -2-1i -6+4i -6-4i];
K = place(A,B,P1);

P2 = [-8+1i -8-1i -6+4i -6-4i];
LT = place(A',C',P2);
L = LT';



e1 = x1 - w(1);
e2 = x2;
E12 = [e1;e2];
e3 = x3 - w(2);
e4 = x4;
E = [e1;e2;e3;e4];

U = -K*x_hat;

S = [0 1 0;-1 0 0;0 0 0];

Phi = [0 1 0;0 0 1;0 -1 0];
Psi = [1 0 0];

M1 = [0 1 0;0 0 1;-1 -2 -3];
N1 = [0;0;1];
T1=sylv(M1,-Phi,-N1*Psi);
T2 = T1;



u2w = (-(a1+1)*b3*w(1)-a2*b3*w(2)+b1*w(3))/(-b1*b4+b2*b3);
u1w = -(b4*u2w+w(3))/(b3);

u1ss = Psi*inv(T1)*eta1;

% u1bar = -30*(e1+e2+(x3-w(2))+x4);
u1bar = U(1);

u1 = u1ss + u1bar;

u2ss = Psi*inv(T2)*eta2;
% u2bar = -50*(e1+e2+(x3-w(2))+x4);
u2bar = U(2);
u2 = u2ss + u2bar;

% miu_k(:,k)=Psi*tau - u1w;  
% miu_k(:,k)=u1ss - u1w; 

dx = zeros(17,1);                                        %% a column vector
% Plant 
dx(1) = x3;
dx(2) = x4;
dx(3) = a1*x1 + a2*x3 + b1*u1 + b2*u2;
dx(4) = a3*x4 + b3*u1 + b4*u2 + w(3);
dx(5:7) = S*w;
dx(8:10) = M1*eta1 + N1*u1;
dx(11:13) = M1*eta2 + N1*u2;
dx(14:17) = A*x_hat + B*U + L*(E12 - C*x_hat);


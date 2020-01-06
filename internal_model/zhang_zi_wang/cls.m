function dx=cls(t,x)

global S;
global k1;
global k2;
global omega;

dx=zeros(12,1);
%x(1:4) state
%x(5:8) exo
%x(9:12) internal mode

A=[0 0 1 0;
   0 0 0 1;
   -1.7117 0 -0.3249 0;
   0 0 0 -1.004];
B=[0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1];
C=[1 0 0 0;
    0 1 0 0];

R=[0.0503 0.0959;
    -0.1228 0.1];

M=[0 1;
    -0.7017 -0.7017];
N=[0;1];
phi=[0 1;-omega^2 0];

psi=[1 0];

a=-M;
b=phi;
c=N*psi;
T=sylvester(a,b,c);

ex(1)=x(1)-x(5);
ex(2)=x(2)-x(7);

ev(1)=x(3)-x(6);
ev(2)=x(4)-x(8);

ep=k2*ex+ev;

us=zeros(2,1);                                                                                                                   
us(1)= -k1*(1+ep(1)^2)*ep(1)+psi*inv(T)*x(9:10);
us(2)= -k1*(1+ep(2)^2)*ep(2)+psi*inv(T)*x(11:12);


dx(1:4)=A*x(1:4)+B*inv(R)*us;
dx(5:8)=S*x(5:8);
dx(9:10)=M*x(9:10)+N*us(1);
dx(11:12)=M*x(11:12)+N*us(2);

end
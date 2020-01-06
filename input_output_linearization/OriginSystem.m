function dxdt = OriginSystem(t, x)

x1 = x(1);
x2 = x(2);
x3 = x(3);
w = x(4:5);

% use the exo-system construct reference signal: yd=sin(t)
S = [0 1;-1 0];
C = [1 0];
% system output
y = x1;
y_dot = sin(x2)+(x2+1)*x3;

% the exo-system as the reference
yd = C*w;
yd_dot = C*S*w;
yd_ddot = C*S*S*w;

% the error signal
e = y - yd;
e_dot = y_dot - yd_dot;

% k is feedback gain, and v is equivalent input
k1 = 1;
k2 = 1;
v = yd_ddot - k1*e - k2*e_dot;

% the 2-order derivative of y=(x2+1)*u+f1(x)
f1 = (x1^5+x3)*(x3+cos(x2))+(x2+1)*x1^2;

% the actual control input
u = (1/(x2+1))*(v-f1);

dxdt = zeros(5, 1);

% plant dynamics
dxdt(1) = sin(x2)+(x2+1)*x3;
dxdt(2) = x1^5+x3;
dxdt(3) = x1^2+u;

% exosystem dynamics
dxdt(4:5) = S*w;

end


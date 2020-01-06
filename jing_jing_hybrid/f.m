function xdot = f(x)

%%%%%%%%%%%%%%
%flow map
%%%%%%%%%%%%%

% load the parameters
parameter;

% state
xi = x(1:20);
zeta = x(21:24);
tau = x(25);
kapa = x(26);


% differential equations
xdot = zeros(26, 1);
xdot(1:20) = Ac*xi + Bbar*zeta;
xdot(21:24) = -Cc*Ac*xi - Cc*Bbar*zeta;
xdot(25) = 1;
xdot(26) = 0;

end


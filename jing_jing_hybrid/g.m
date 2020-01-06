function xplus = g(x)
%%%%%%%%%%
%jump map of the hybrid automaton
%%%%%%%%%%

% load the parameters
parameter;

% state
xi = x(1:20);
zeta = x(21:24);
tau = x(25);
kapa = x(26);

xplus = zeros(26,1);
xplus(1:20) = xi;
xplus(21:24) = 0;
xplus(25) = 0;
xplus(26) = kapa + 1;


end


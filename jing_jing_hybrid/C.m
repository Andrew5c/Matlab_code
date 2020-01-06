function [value discrete] = C(x)

%%%%%%%%%%%
%flow set of the hybrid automaton
%%%%%%%%%%%
tau = x(25);
T = 0.1;

if (tau >= 0 && tau <= T)
    value = 1;
else
    value = 0;
end
end


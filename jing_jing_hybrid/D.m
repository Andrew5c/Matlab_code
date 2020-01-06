function inside = D(x)

%%%%%%%%%%%%
%jump set of the hybrid automaton
%%%%%%%%%%%
tau = x(25);
T = 0.1;

if (tau >= T)
    inside = 1;
else
    inside = 0;
end
end

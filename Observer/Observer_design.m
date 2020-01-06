clear all
clc

%%
A = [0 1; 20.6 0];
B = [0; 1];
C = [1 0];
D = [0];

Q = [B, A*B];
originK = rank(Q);
fprintf('rank of the origin system is : %d\n', originK);

if originK == 2
    fprintf('system controllable.\n');
else
    fprintf('system uncontrollable.\n');
end

J = [-1.8+2.4i 0; 0 -1.8-2.4i];
phi = polyvalm(poly(J), A);
K = [0 1] * inv(Q) * phi;
RT = [C; C*A];
rank(RT);


x0 = [2; 1];
[x,t] = initial(A-B*K,x0);
plot(t, x(:,1), t,x(:,2))
grid
title('response to initial condition')


%%
Atue = A';  Btue = C';
Qnew = [Btue, Atue*Btue];
Jobserver = [-8 0; 0 -8];
phiNew = polyvalm(poly(Jobserver), Atue);
K = [0 1] * inv(Qnew) * phiNew ;
Ke = K'





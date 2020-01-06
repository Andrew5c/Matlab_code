function RUN

% initial conditions
xi_0 = 0.1*ones(20,1);    %q
zeta_0 = [0.2;0.2;0.2;0.2];   %z1
tau_0 = 0;    %z2
kapa_0 = 0;    %z2

x0 = [xi_0; zeta_0; tau_0; kapa_0];

% simulation horizon
TSPAN = [0 20];
JSPAN = [0 100];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.01);

maxStepCoefficient = .1;  % set the maximum step length. At each run of the
                   % integrator the option 'MaxStep' is set to
                   % (time length of last integration)*maxStepCoefficient.
                   %  Default value = 0.1

% simulate
[t x j] = HyEQsolver( @f,@g,@C,@D,x0,TSPAN,JSPAN,rule,options,maxStepCoefficient);

% plot the error xi
figure(1)
plotflows(t,j,x(:,1));
hold on
plotflows(t,j,x(:,2));
hold on
plotflows(t,j,x(:,3));
hold on
plotflows(t,j,x(:,4));
hold on
plotflows(t,j,x(:,5));
hold on
plotflows(t,j,x(:,6));
hold on
plotflows(t,j,x(:,7));
xlabel('t')
ylabel('xi')

% plot the zeta
figure(2)
plotflows(t,j,x(:,21));
hold on
plotflows(t,j,x(:,22));
hold on
plotflows(t,j,x(:,23));
hold on
plotflows(t,j,x(:,24));
xlabel('t')
ylabel('zeta')
% grid on

% plot solution
% figure(1)
% clf
% subplot(2,1,1),plotflows(t,j,x(:,1))
% grid on
% ylabel('tau')
% 
% subplot(2,1,2),plotflows(t,j,x(:,26))
% grid on
% ylabel('kapa')
% 
% figure(2) % velocity
% clf
% subplot(2,1,1),plotjumps(t,j,x(:,25))
% grid on
% ylabel('tau')
% 
% subplot(2,1,2),plotjumps(t,j,x(:,26))
% grid on
% ylabel('kapa')
% % plot hybrid arc
% plotHybridArc(t,j,x)
% xlabel('j')
% ylabel('t')
% zlabel('x1')

end



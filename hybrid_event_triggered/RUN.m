function RUN

global rou_d w_d

% the desired attitude trajectory
rou_d = [-0.2264 0.3397 -0.3397]';
w_d = [ 0 0 0]';

% initial conditions
rou_0 = [0 0 0];
w_0 = [0.3 0.1 0.2];
x0 = [rou_0 w_0]';

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



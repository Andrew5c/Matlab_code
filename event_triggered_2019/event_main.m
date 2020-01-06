clc
clear all

global rou_d w_d
global flag

global u_k t_k k
k = 1;

% flag for event
flag = 1;

% the desired attitude trajectory
rou_d = [-0.2264 0.3397 -0.3397]';
w_d = [ 0 0 0]';

rou_0 = [0 0 0];
w_0 = [0.3 0.1 0.2];
x_0 = [rou_0 w_0]';
tspan = [0, 40];

[t,X] = ode23('event_sys', tspan, x_0);

figure
plot(t, X(:,1), 'b', 'LineWidth',1.5);
hold on
plot(tspan, [rou_d(1) rou_d(1)], 'r--');
hold on
plot(t, X(:,2), 'r', 'LineWidth',1.5);
hold on
plot(tspan, [rou_d(2) rou_d(2)], 'r--');
hold on
plot(t, X(:,3), 'g', 'LineWidth',1.5);
hold on
plot(tspan, [rou_d(3) rou_d(3)], 'r--');
axis([0 40 -0.4 0.6])
title('Attitude regulation performance');
xlabel('Time t (second)');
legend('\rho_{1}','\rho_{1d}','\rho_{2}','\rho_{2d}','\rho_{3}','\rho_{3d}');

figure
plot(t, X(:,1)-rou_d(1), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,2)-rou_d(2), 'r', 'LineWidth',1.5);
hold on
plot(t, X(:,3)-rou_d(3), 'g', 'LineWidth',1.5);
%axis([0 40 -0.4 0.6])
title('Attitude regulation error');
xlabel('Time t (second)');
legend('e_{1}','e_{2}','e_{3}');

figure
plot(t, X(:,4), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,5), 'r', 'LineWidth',1.5);
hold on
plot(t, X(:,6), 'g', 'LineWidth',1.5);
%axis([0 40 -0.4 0.6])
title('Angular velocity');
xlabel('Time t (second)');
legend('w_{1}','w_{2}','w_{3}');

figure
plot(t_k, u_k(1,:),'b', 'LineWidth',1);
hold on;
plot(t_k, u_k(2,:),'r', 'LineWidth',1);
hold on
plot(t_k, u_k(3,:),'g', 'LineWidth',1);
%axis([0 25 -12 6]);
title('Control Inputs');
xlabel('Time t (second)');
legend('u_{1}','u_{2}','u_{3}');




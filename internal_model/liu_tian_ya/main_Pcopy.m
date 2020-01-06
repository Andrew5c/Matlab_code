clc; 
clear all;

x0 = [2 1 0 0];
v0 = [0 1 0];
z0 = [1 0 2 1 0 2];
x_hat0 = [2 1 0 0];

x_0 = [x0 v0 z0 x_hat0]';
tspan = [0, 20];

[t,X] = ode45('Pcopy', tspan, x_0);


figure
plot(t, X(:,1)-X(:,5), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,2), 'r', 'LineWidth',1.5);
title('Tracking error e(t)');
xlabel('Time t (second)');
legend('e1','e2');


figure
plot(t, X(:,1), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,2), 'r', 'LineWidth',1.5);
hold on
plot(t, X(:,3), 'c', 'LineWidth',1.5);
hold on
plot(t, X(:,4), 'g', 'LineWidth',1.5);
title('System state x(t)');
xlabel('Time t (second)');
legend('x1','x2','x3','x4');


figure
plot(t, X(:,5), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,6), 'r', 'LineWidth',1.5);
hold on
plot(t, X(:,7), 'c', 'LineWidth',1.5);
title('Exosystem state v(t)');
xlabel('Time t (second)');
legend('v1','v2','v3');




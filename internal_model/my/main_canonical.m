clc 
clear all


global uk tk k;
k = 1;


x0 = [0 0 0 0];
v0 = [0 0.1 0];
eta0 = [0 0 0 0 0 0];
x_hat0 = [0 0 0 0];

x_0 = [x0 v0 eta0 x_hat0]';
tspan = [0 20];

[t,X] = ode23(@canonical, tspan, x_0);

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

figure
plot(tk, uk(1,:),'b', 'LineWidth',1.5);
hold on;
plot(tk, uk(2,:),'r', 'LineWidth',1.5);
title('Control Input u(t)');
xlabel('Time t (second)');
legend('u1','u2');



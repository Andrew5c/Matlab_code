clear all
clc

x0 = [4 3];
w0 = [1 0];
x_0 = [x0 w0]';
tspan = [0, 20];

[T,X] = ode45('full_infor', tspan, x_0);



figure
plot(T, X(:,1)-X(:,3), 'b', 'LineWidth',1.5);
hold on
plot(T, X(:,1), 'r', 'LineWidth',1.5);
title('State');
xlabel('Time t (second)');
legend('x1','x2');
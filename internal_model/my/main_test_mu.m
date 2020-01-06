clc; 
clear all;

x0 = [4 2 1 0]';

tspan = [0, 20];

[t,X] = ode23('test_mu', tspan, x0);


figure
plot(t, X(:,1), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,2), 'r', 'LineWidth',1.5);
title('Tracking error e(t)');
xlabel('Time t (second)');
legend('x1','x2');

clc
clear all

% call this file to calculate the matries L and M
calculate_L_M;

% give initial conditions
v0 = [0 1 0 2 0 3];
x10 = zeros(1,6);
x20 = zeros(1,6);
x30 = zeros(1,6);
x40 = zeros(1,6);

x_0 = [v0 x10 x20 x30 x40]';
tspan = [0, 7];

[t,X] = ode45('TAC2019_obs', tspan, x_0');

figure
h1 = plot(t, X(:,1:6), 'k', 'LineWidth',1);
hold on
h2 = plot(t, X(:,7:12), 'g--', 'LineWidth',1);
hold on
h3 = plot(t, X(:,13:18), 'b--', 'LineWidth',1);
hold on
h4 = plot(t, X(:,19:24), 'r--', 'LineWidth',1);
hold on
h5 = plot(t, X(:,25:30), 'm--', 'LineWidth',1);
hold on
axis([0 7 -4 4])
title('State of the observed and estimate');
xlabel('Time t (sec)');
legend([h1(1),h2(1),h3(1),h4(1),h5(1)],'x','x_{1}','x_{2}','x_{3}','x_{4}');
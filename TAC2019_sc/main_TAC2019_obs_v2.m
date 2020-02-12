clc
clear all

% call this file to calculate the matries L and M
calculate_L_M_v2;

% give initial conditions
v0 = [0 1 0 2 0 0];
x_obs10 = [0 0 0 0 1 2];
x_obs20 = [0 0 0 0 0.8 -1];
x_obs30 = [0 0 0 0 1 -1.2];
x_obs40 = [0 0 0 0 -0.4 1.3];

x_follow10 = [0 0 0 0];
x_follow1_hat0 = [0 0 0 0];
z_0 = [0 0 0 0 0 0];

x_0 = [v0 x_obs10 x_obs20 x_obs30 x_obs40 x_follow10 x_follow1_hat0 z_0]';
tspan = [0, 10];

[t,X] = ode23('TAC2019_obs_v2', tspan, x_0');

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
legend([h1(1),h2(1),h3(1),h4(1),h5(1)],'v','x_{1}','x_{2}','x_{3}','x_{4}');

figure
plot(t, X(:,31)-X(:,7), 'b', 'LineWidth',1.5);
hold on
plot(t, X(:,32), 'r', 'LineWidth',1.5);
title('Tracking error of follow 1');
xlabel('Time t (second)');
legend('e_{1}','e_{2}');


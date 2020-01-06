clear all
clc

[T, X] = ode45('originSYS', [0 5], [2 1 5 2]);

figure(1)
plot(T, X(:,3), '-r', 'LineWidth',1.5);
hold on
plot(T, X(:,4), '-g', 'LineWidth',1.5);
title('State Feedback Control');
legend('x1','x2');
xlabel('Time(sec.)');
grid on


clear all
clc


[T, X] = ode23('OriginSystem', [0 20], [3 2 1 0 1]);

figure(1)
plot(T, X(:,1), '-r', 'LineWidth',1.5);
hold on
plot(T, X(:,3), '-b', 'LineWidth',1.5);
hold on
plot(T, X(:,4), '-g', 'LineWidth',1.5);
title('Input-Output Linearization');
legend('x1','x2','ref');
xlabel('Time(sec.)');
grid on

figure(2)
plot(T, X(:,1)-X(:,4), '-r', 'LineWidth', 1.0);
title('Tracking Error');
%legend('x1');
xlabel('Time(sec.)');
grid on
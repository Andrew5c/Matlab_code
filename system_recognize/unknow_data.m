clear all
clc

load E:\Control_Matlab\system_recognize\data065_OrderUnKnown.mat
% length of the data
length = size(u(:));
x = 1:length;
plot(x, u(x), 'b', 'LineWidth',0.8);
hold on;
plot(x,y(x),'r', 'LineWidth',0.5);
xlabel('Time /t');
ylabel('Data');
legend('input u(t)','output y(t)');
title('system data');


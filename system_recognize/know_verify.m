clear all
clc

load E:\Control_Matlab\system_recognize\data065_OrderKnown.mat
v=randn(501,1);
z=zeros(501,1);
z(1)=1;
z(2)=2;
z(3)=1;
z(4)=8;
for i=5:100
z(i)=-0.8836*z(i-1)-0.7001*z(i-2)-0.6876*z(i-3)+4.9973*u(i-2)+4.9138*u(i-3)+v(i)+0.0046*v(i-1);
end
t=1:100;
plot(t,z(t),'r', 'LineWidth',1.5);
hold on;
plot(t,y(t),'b', 'LineWidth',1.5);
grid;
legend('Identified','Original');
xlabel('Time /t');
ylabel('Output');
title('Identified vs Original');


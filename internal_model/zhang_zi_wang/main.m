global k1;
global k2;
global S;
global omega;

clc;
close all;
k1=5;
k2=2;


%x(1:4) state
%x(5:8) exo
%x(9:12) internal mode

omega = 0.1*pi;
S=[0 1 0 0;
    -omega^2 0 0 0;
    0 0 0 1;
    0 0 -omega^2 0];

A1=0.5;
A2=0.5;


tspan=[0,100];
x0=[2 1 0 0 0 A1*omega A2 0 0 0 0 0];

[t,x]=ode45(@cls,tspan,x0);


figure(1)
plot(t,x(:,1)-x(:,5));
grid on;
hold on;
plot(t,x(:,2)-x(:,7));
legend('1','2');


figure(2)
plot(t,x(:,9));
grid on;
hold on;
plot(t,x(:,11));




 clc; 
clear all;
%close all;
global K1
global K2
K1=[10 20;15 35];   
K2=[2.3015 6.1678 5.7061;2.8262 7.5741 -2.9929];

x0=[0; 0; 1; 0; 0; 0; 0];


T=60;
%tspan   = [0,T];
%options = odeset('AbsTol',1e-9,'RelTol',1e-5);
%[t,X]   = ode15s(@fun,tspan,x0,options);
[t,X] = ode45(@strict_feedback,[0 T],x0);



figure
plot(t,X(:,1)-X(:,5)-X(:,6),'b','LineWidth',1.5);
hold on
plot(t,X(:,2),'r','LineWidth',1.5);
title('Tracking error e(t)');
xlabel('Time t (second)') 

legend('e_1','e_2')


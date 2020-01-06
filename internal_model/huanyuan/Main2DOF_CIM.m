clc; 
clear all;
global Psi T miu_k k;
k = 0;
% x0=[0 3 0 1 0 1 1 1 1 1 1 1 1 (0.3-0.5*1)/0.14+10*1 0.7/0.14 -0.3/0.14]; 
x0=[0 3 0 1 0 1 5 0 0 0 0 0 0 0 0 0 0]; 

TT=30;

[t,X] = ode23s(@TwoDOF_CIM,[0 TT],x0);
 
figure(1)
subplot(4,1,1)
% plot(t,Psi*inv(T)*X(:,11:13)','b','LineWidth',1.5);
plot(t,X(:,2),'b','LineWidth',1.5);
grid on
title('x')

subplot(4,1,2)
plot(t,X(:,1)-X(:,5),'b','LineWidth',1.5);
grid on
title('e')

subplot(4,1,3)
plot(t,X(:,5:7),'b','LineWidth',1.5);
grid on
title('e')

% subplot(4,1,4)
% plot(miu_k(1,:),'r','LineWidth',1.5);
% grid on
% title('e')

clear all; clc
load E:\Control_Matlab\system_recognize\data065_OrderUnKnown.mat

v=randn(501,1);
P=100*eye(10);
Pstore=zeros(10,501);
Pstore(:,1)=[P(1,1),P(2,2),P(3,3),P(4,4),P(5,5),...
    P(6,6),P(7,7),P(8,8),P(9,9),P(10,10)];
Theta=zeros(10,500);
Theta(:,1)=[1,2,3,4,5,6,7,8,9,10];
K=[5,5,5,5,5,5,5,5,5,5];
for i=9:501
    h=[-y(i-1);-y(i-2);-y(i-3);u(i-4);u(i-5);u(i-6);...
        u(i-7);v(i-1);v(i-2);v(i-3)];
    K=P*h*inv(h'*P*h+1);
    Theta(:,i-1)=Theta(:,i-2)+K*(y(i)-h'*Theta(:,i-2));
    P=(eye(10)-K*h')*P;  Pstore(:,i-1)=[P(1,1),P(2,2),...
        P(3,3),P(4,4),P(5,5),P(6,6),P(7,7),P(8,8),P(9,9),P(10,10)];
end
disp('a1,a2,a3,b0,b1,b2,b3,c1,c2,c3:')
Theta(:,500)
i=1:500;
figure(1)
plot(i,Theta(1,:),'r',i,Theta(2,:),'r--',i,Theta(3,:),'g',...
    i,Theta(4,:),'g--',i,Theta(5,:),'b',i,Theta(6,:),'b--',...
    i,Theta(7,:),'y',i,Theta(8,:),'m',i,Theta(9,:),'m--',i,Theta(10,:),'c')
legend('a1','a2','a3','b0','b1','b2','c1','c2','c3');
title('Parameter Identification Result')
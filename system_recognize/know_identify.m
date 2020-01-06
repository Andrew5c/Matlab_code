clear all
clc

load E:\Control_Matlab\system_recognize\data065_OrderKnown.mat
% add noises
xi=randn(501,1);
P=67*eye(6);
Pstore=zeros(6,501);
Pstore(:,1)=[P(1,1),P(2,2),P(3,3),P(4,4),P(5,5),P(6,6)];
Theta=zeros(6,401);
% the initial paramerter
Theta(:,1)=[1,2,3,4,5,6];
K=[10,10,10,10,10,10];
for i=5:501
    % sampling the current data
    h=[-y(i-1);-y(i-2);-y(i-3);u(i-2);u(i-3);xi(i-1)];
    % the RELS algorithm
    K=P*h*inv(h'*P*h+1);
    Theta(:,i-1)=Theta(:,i-2)+K*(y(i)-h'*Theta(:,i-2));
    P=(eye(6)-K*h')*P;
    Pstore(:,i-1)=[P(1,1),P(2,2),P(3,3),P(4,4),P(5,5),P(6,6)];
end
% output data for use
disp('a1,a2,a3,b0,b1,c1:')
Theta(:,500)
i=1:500;
figure(1)
plot(i,Theta(1,:),'r',i,Theta(2,:),'r-.',i,Theta(3,:),'g-.',i,Theta(4,:),'g--',i,Theta(5,:),'b-.',i,Theta(6,:),'b--')
legend('a1','a2','a3','b0','b1','c1');
title('Parameter Identification Result')
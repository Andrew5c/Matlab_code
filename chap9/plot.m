close all;

figure(1);
% subplot(211);
plot(t,y(:,1),'g',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('ideal position','position tracking');
% subplot(212);
% plot(t,0.1*cos(t),'r',t,y(:,3),'k:','linewidth',2);
% xlabel('time(s)');ylabel('dyd,dy');
% legend('ideal speed','speed tracking');

% figure(2);
% plot(t,u(:,1),'r','linewidth',2);
% xlabel('time(s)');ylabel('Control input');

figure(3);
plot(t,fx(:,1),'b',t,fx(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('fx');
legend('Practical fx','fx estimation');

figure(4);
plot(t,fx(:,1)-fx(:,2),'b','linewidth',2);
xlabel('time(s)');ylabel('err');
legend('Estimation error');

figure(5);
plot(t,y(:,1)-y(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('err');
legend('Tracking error');


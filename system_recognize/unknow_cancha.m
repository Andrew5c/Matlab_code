clear all; clc
load E:\Control_Matlab\system_recognize\data065_OrderUnKnown.mat
z=[y,u];
nz=size(z(:,1));
x=1:nz;
for n=1:8
    na=n; nb=n; nc=n;
    nn=na+nb+nc+1;
    J=zeros(1,100);
    for d=0:99
        thitak=ones(nn,1)*0.001;
        thita=zeros(3*n+1,501);
        K=zeros(nn,1);
        I=eye(nn,nn);
        p1=eye(nn,nn)*(1.0e6);
        p2=zeros(nn,nn);
        e=zeros(501,1);
        for i=na+1+d:na+201+d
          Q=[[-z(i-1:-1:i-na,1)]',[z(i:-1:i-nb,2)]',[e(i-1:-1:i-nc,1)]'];
          K=p1*Q'/(Q*p1*Q'+1);
          p2=(I-K*Q)*p1;
          thita(:,i)=thitak+K*(z(i,1)-Q*thitak);
          p1=p2;
          thitak=thita(:,i);
          e(i)=z(i,1)-Q*thitak;
          J(1,d+1)=e(i)*e(i)+J(1,d+1);
        end
    end
    d=find(J==min(J));
    JJ(n)=min(J);
end
figure(2)
n=1:8;
plot(n,JJ(n),'r*','LineWidth',1.5);
line(n,JJ(n),'LineWidth',1.5);
grid on;
xlabel('time /n');
ylabel('J(n)');
title('Residual error');


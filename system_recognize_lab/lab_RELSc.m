%主函数，基于残差平方和模型定阶RELS算法，确定阶次、延时，辨识参数
clear all;
close all;
m=xlsread('2019-12-14-11-33-26DataDemo_Sequence_Identy.csv');
[N,M]=size(m);                  %数组长度，N为1499
J1=zeros(5,5);       
y=m(:,4);u=m(:,2);
z=[y u];                 %输入输出组合矩阵
for i=1:5                %阶次试1-5阶
    J1(i,:)=rels3(z,i,i,i);
end
    figure(1);
    x=1:5;
    plot(x,J1(1,:),'r'); hold on;
    plot(x,J1(2,:),'r--');
    plot(x,J1(3,:),'g');
    plot(x,J1(4,:),'g--');
    plot(x,J1(5,:),'b');
    legend('n=1','n=2','n=3','n=4','n=5');
    xlabel('d');ylabel('J_d'); title('1');
    %绘图显示，确定模型阶次 n=3
    figure(2);
    x=1:5;
    plot(x,J1(:,1),'r'); hold on;
    plot(x,J1(:,2),'r--');
    plot(x,J1(:,3),'g');
    plot(x,J1(:,4),'g--');
    plot(x,J1(:,5),'b');
    legend('d=1','d=2','d=3','d=4','d=5');
    xlabel('n');ylabel('J_n'); title('2');
    %延迟、阶次确定后辨识参数
    thita=rels1(z,3,3,3);
    %绘图显示辨识参数
    figure(3);
    x=1:N;
    plot(x,thita(1,x),'r');hold on;
    plot(x,thita(2,x),'r--');
    plot(x,thita(3,x),'r-');
    plot(x,thita(4,x),'b');
    plot(x,thita(5,x),'b--');
    plot(x,thita(6,x),'b-');
     plot(x,thita(7,x),'g');
      plot(x,thita(8,x),'g--');
       plot(x,thita(9,x),'g-');
       grid;
       legend('a1','a2','a3','b1','b2','b3','c1','c2','c3');
       xlabel('k');ylabel('Thita');title('3RELS')
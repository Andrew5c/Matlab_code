%定延迟和阶数函数rels3
function J=rels3(z,na,nb,nc)   
%nz=size(z(:,1));                      %z的行数数据行数 1499
nn=na+nb+nc+1;
thitak=ones(nn,1)*0.001;
thita=zeros(nn,501);
K=zeros(nn,1);
I=eye(nn,nn);
p1=eye(nn,nn)*(1.0e6);
p2=zeros(nn,nn);
e=zeros(501,1);
J=zeros(1,5);
for d=0:4
    for i=na+1+d:501;
          Q=[[-z(i-1:-1:i-na,1)]',[z(i:-1:i-nb,2)]',[e(i-1:-1:i-nc,1)]'];
          K=p1*Q'/(Q*p1*Q'+1);
          p2=(I-K*Q)*p1;
          thita(:,i)=thitak+K*(z(i,1)-Q*thitak);
          p1=p2;
          thitak=thita(:,i);
          e(i)=z(i,1)-Q*thitak;
          J(d+1)=e(i)*e(i)+J(d+1);
        
        %J(d+1)=J(d+1)+[z(k,1)-[[-z(k-1:-1:k-na,1)]',[z(k-d-1:-1:k-d-nb,2)]',[e(k-1:-1:k-nc)]']*thita(:,501)]^2;
    end
   % for k=na+d+1:501
   %   J(d+1)=J(d+1)+[z(k,1)-[[-z(k-1:-1:k-na,1)]',[z(k-d-1:-1:k-d-nb,2)]',[e(k-1:-1:k-nc)]']*thita(:,501)]^2;
   % end
end
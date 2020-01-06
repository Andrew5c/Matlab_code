
% Exosystem Paremeter
S=[0,1,0;-1,0,0;0,0,0];

% Plant Paremeter
A=[0,1;0,0]; B=[0;1]; C=[1,0];
E1=[0,0,0;0,0,1]; E2=[0,0,0;0,0,2]; 
E3=[0,0,0;0,0,3]; E4=[0,0,0;0,0,4];
F=[-1,-1,0];

% Internal Model 
G1=[0,1,0;0,0,1;0,-1,0];
G2=[0;0;1];

% Compute Paremeter K1, K2 (by Riccati)
Y=[A,zeros(2,3);G2*C,G1];
J=[B;zeros(3,1)];
[m_R,n_C]=size(Y);
M_l=ctrb(Y,J);
m_l=rank(M_l);
if m_l>=m_R % judgmet controllability
    J1=J*J';
    P=are(Y,J1,eye(5));
end
v_L1=1/3;
K=-inv(v_L1)*J'*P;
Kx=K(1:2);
Kz=K(3:5);

A_G=[0 1 1 0;1 0 0 0;1 0 0 1;0 0 1 0];    % simple graph 
delta=diag([1,0,1,0]);
H = [1,0,0,0;-1,2,0,-1;-1,-1,3,0;0,-1,-1,2];

[x_H,y_H]=eig(H); % eigenvalues of matrix H

I_p=eye(1); 
Atilde=blkdiag(A,A,A,A);
Btilde=blkdiag(B,B,B,B);
Cbar=blkdiag(C,C,C,C);
Ctilde=kron(H,I_p)*blkdiag(C,C,C,C);
Ftilde=kron(delta*[1;1;1;1],F);
Etilde=[E1;E2;E3;E4];

G1tilde=blkdiag(G1,G1,G1,G1);
G2tilde=blkdiag(G2,G2,G2,G2);
Kxtilde=kron(H,I_p)*blkdiag(Kx,Kx,Kx,Kx);
Kztilde=blkdiag(Kz,Kz,Kz,Kz);


Ac=[kron(eye(4),A)+kron(H,B*Kx), kron(eye(4),B*Kz); kron(H,G2*C), kron(eye(4),G1)];
Cc=[Ctilde,zeros(4,12)];
Bbar=[zeros(8,4);G2tilde];


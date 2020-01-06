function dy = test_mu(t,y)

x=y(1:4);   % plant state

A=[0 0 1 0;
    0 0 0 1;
    -1.7117 0 -0.3249 0;
    0 0 0 -1.0004];
B=[0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1];

dy = zeros(4, 1);
% plant dynamics, only the last equation add the uncertainty:w 
dy(1:4) = A*x + B*mu(x);

end


%% define the function mu:mu(0)=0
function mu_output = mu(mu_input)
A=[0 0 1 0;
    0 0 0 1;
    -1.7117 0 -0.3249 0;
    0 0 0 -1.0004];
B=[0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1];
P=[-1-2i -1+2i  -4+5i -4-5i];
K=place(A,B,P);

% define rou in [0,M]
temp = zeros(4,1);
rou = 6;
for i=1:1:4
    temp(i) = (rou/2) * (1-exp(-mu_input(i)))/(1+exp(-mu_input(i)));
end
mu_output = -K*temp;
end



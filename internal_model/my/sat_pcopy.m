function dy = sat_pcopy(t,y)

global uk tk k;

x=y(1:4);   % plant state
v=y(5:7);   % exosystem state
xi_x=y(8:11);  % internal model state
xi_w=y(12:14);

A=[0 0 1 0;
    0 0 0 1;
    -1.7117 0 -0.3249 0;
    0 0 0 -1.0004];
B=[0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1];
C=[1 0 0 0;0 1 0 0];

a1=-1.7117; a2=-0.3249; a3=-1.0004;
b1=0.0503; b2=0.0959; b3=-0.1228; b4=0.1;

c1=(a1+1)/(b1*b4/b3-b2);    % 5.2002
c2=a2/(b1*b4/b3-b2);        % 2.3739
d1=-b4/b3*c1;   % 4.2347
d2=-b4/b3*c2;   % 1.9332

% find the relationship of Xss with v, then get my_pi
my_pi = [1 0 0;0 0 0;0 1 0;0 0 0];
my_tau = [d1 d2 0;c1 c2 0];

% exosystem : v1=sin(t), v2=cos(t), v3=v3(0)
S=[0 1 0;-1 0 0;0 0 0];

% disterbance and reference signal
P=[0 0 1;0 0 2;0 0 0;1 1 1];
Q=[-1 0 0;0 0 0];

%for the saturation control
A_tue = [A P;zeros(3,4) S];   % 7x7
C_tue = [C Q];  % 2x7
P0 = [-1+2i -1-2i -2+1i -2-1i -3+4i -3-4i -5];
G = place(A_tue', C_tue', P0);
G = G'; % 7x2
G_1 = G(1:4,:);
G_2 = G(5:7,:);


% regulated output
e = C*x + Q*v;
% controler
u = my_tau*xi_w + mu(xi_x - my_pi*xi_w);

% for record the output
uk(:,k) = u;
tk(:,k) = t;
k = k + 1;

dy = zeros(14, 1);
% plant dynamics, only the last equation add the uncertainty:w 
dy(1:4) = A*x + B*saturation(u) + P*v;
% exosystem, produce sin reference signal, and constant parameter uncertainty
dy(5:7) = S*v;
% controller for the saturation input
dy(8:11) = A*xi_x + B*saturation(u) + P*xi_w - G_1*(C*xi_x + Q*xi_w - e);
dy(12:14) = S*xi_w - G_2*(C*xi_x + Q*xi_w - e);
end


%% define the saturation function
function sat_output = saturation(sat_input)
% define the maxmum allowed value of output
M = 50;
temp_output = zeros(2,1);

for icount=1:1:2
    if sat_input(icount)>M
        temp_output(icount) = M;
    elseif sat_input(icount)<-M
        temp_output(icount) = -M;
    else
        temp_output(icount) = sat_input(icount);
    end
end
sat_output = temp_output;
end


%% define the function mu:mu(0)=0
function mu_output = mu(mu_input)
% calculate the feedback gian
A=[0 0 1 0;
    0 0 0 1;
    -1.7117 0 -0.3249 0;
    0 0 0 -1.0004];
B=[0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1];
P=[-7-2i -7+2i  -8+5i -8-5i];
K=place(A,B,P);

% define rou in [0,M]
temp = zeros(4,1);
rou = 6;
for i=1:1:4
    temp(i) = (rou/2) * (1-exp(-mu_input(i)))/(1+exp(-mu_input(i)));
end
mu_output = -K*temp;
end




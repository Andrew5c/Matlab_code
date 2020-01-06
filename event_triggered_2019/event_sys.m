function dydt = event_sys(t, x)
%---------------------------------
% this function for the event triggered attitude regualtion
% to build the attitude error system
% Simulation for the <event-triggered attitude regulation of rigig spacecraft with 
% uncertain inertia matrix>---2019---ASCC
%---------------------------------

global flag
global rou_d w_d
global e_tk z_tk

global u_k t_k k

% parameter designed
k1 = 1;
sigma = 0.5;
varepsilon_star = 0.01;
% inertia matrix
J = diag([10 10 8]);

% save the data of t_k time for compare
if flag == 1
    flag = 0;
    rou_tk = x(1:3);
    w_tk = x(4:6);
    % error vector
    e_tk = rou_tk - rou_d;
    % transformed angular velocity vector
    z_tk = k1*e_tk + w_tk - w_d;
end
% and cal the up to date data for compare
rou = x(1:3);
w = x(4:6);
e = rou - rou_d;
z = k1*e + w - w_d;

% event-based controller
u = Lambda_function(z_tk);
u_k(:,k) = u;
t_k(:,k) = t;
k = k+1;

% event-triggering mechanism
if norm(u-Lambda_function(z)) - sigma*(norm(Lambda_function(z))) >= varepsilon_star
    flag = 1;
end

f_ez = -k1*H_function(e)*e + H_function(e)*z;
g_ez = k1*X_product(-k1*e + z)*J*e - X_product(-k1*e + z)*J*z - ...
        k1*k1*J*H_function(e)*e + k1*J*H_function(e)*z;
    
dydt = zeros(6,1);
dydt(1:3) = f_ez;
dydt(4:6) = inv(J)*g_ez + inv(J)*u;

end


%% x product function
function x_output = X_product(e)

x_output = [0 -e(3) e(2);
            e(3) 0 -e(1);
            -e(2) e(1) 0];
end

%% H function
function h_output = H_function(e)

e_product = X_product(e);
h_output = (eye(3) + e_product + e*e')/2;
end

%% lambda function
function lambda_output = Lambda_function(z)

lambda_output = -6*(2 + 2*(z'*z))*z;
end


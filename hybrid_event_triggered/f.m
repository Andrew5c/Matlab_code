function xdot = f(x)

%------------
% flow map
%------------

global rou_d w_d
global z_tk

% parameter designed
k1 = 1;
% inertia matrix
J = diag([10 10 8]);

% and cal the up to date data for compare
rou = x(1:3);
w = x(4:6);
e = rou - rou_d;
z = k1*e + w - w_d;

% event-based controller
u = Lambda_function(z_tk);

f_ez = -k1*H_function(e)*e + H_function(e)*z;
g_ez = k1*X_product(-k1*e + z)*J*e - X_product(-k1*e + z)*J*z - ...
        k1*k1*J*H_function(e)*e + k1*J*H_function(e)*z;

% differential equations
xdot = zeros(6, 1);
xdot(1:3) = f_ez;
xdot(4:6) = inv(J)*g_ez + inv(J)*u;

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

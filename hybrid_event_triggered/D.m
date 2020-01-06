function inside = D(x)

%------------
% jump set
%------------
global rou_d w_d
global z_tk

% parameter designed
sigma = 0.5;
varepsilon_star = 0.01;

% and cal the up to date data for compare
rou = x(1:3);
w = x(4:6);
e = rou - rou_d;
z = k1*e + w - w_d;

% event-based controller
u = Lambda_function(z_tk);

% event-triggering mechanism
if norm(u-Lambda_function(z)) - sigma*(norm(Lambda_function(z))) >= varepsilon_star
    inside = 1;
else
    inside = 0;
end
end
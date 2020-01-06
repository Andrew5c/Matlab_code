clear all;
clc;

%% online algorithm
global A B Q R K ;

A = [0 0 1 0;
    0 0 0 1;
    -1.7117 0 -0.3249 0;
    0 0 0 -1.004] ;
B = [0 0;
    0 0;
    0.0503 0.0959;
    -0.1228 0.1] ;
Q = diag([200 75 0 0]) ;
R = 0.005*eye(2,2) ;

%to find the optimal feedback control law k.
%K = zeros(2, 4) ;
K = [90 -100   30  -3;
      15   6   4   15] ;

%inital state
x0 = [1 0 2 3 1]' ;

tspan = 4 ;     % simulation time
T = 20 ;        % sampe times at every interval
dT = 0.05 ;     % sampling period

bar_p = zeros(10, 1) ;
P = zeros(4, 4) ;
delta_x = zeros(10, 1) ;
X = zeros(10, T) ;
Y = zeros(T, 1) ;

p_save = zeros(tspan-1, 1) ;

for j = 1 : tspan
    for i = 1 : T
        [t, x] = ode45(@(t,x) LTIsys2(t,x), [(i-1)*dT+j-1 i*dT+j-1], x0) ;
        n = size(x, 1) ;        %the iterations of OED
        m = length(x(1,:)) ;    %m = 5 in general.
        x0 = x(n, :)' ;   %Save this latest value as the next initial value
        
        %cal the Kronecker product of x
        x_0 = x(1, 1:m-1) ;
        x_n = x(n, 1:m-1) ;
        nums = 1 ;
        bar_x_0 = zeros(10, 1) ;
        bar_x_n = zeros(10, 1) ;
        for temp1 = 1 : m-1
            for temp2 = temp1 : m-1
                bar_x_0(nums) = x_0(temp1) * x_0(temp2) ;
                bar_x_n(nums) = x_n(temp1) * x_n(temp2) ;
                nums = nums + 1 ;
            end
        end
 
        delta_x = bar_x_0 - bar_x_n ;
        X(1:10, i) = delta_x ;      
        Y(i) = x(n, m) - x(1, m) ;  %save the latest value as the current value.
    end
    
    %bar_p = (X*X')\X*Y ;
    bar_p = X'\Y ;
    P = [bar_p(1) bar_p(2)/2 bar_p(3)/2 bar_p(4)/2;
         bar_p(2)/2 bar_p(5) bar_p(6)/2 bar_p(7)/2;
         bar_p(3)/2 bar_p(6)/2 bar_p(8) bar_p(9)/2;
         bar_p(4)/2 bar_p(7)/2 bar_p(9)/2 bar_p(10)] ;
    
    K = R \ B' * P ;
    if j>1
        p_save(j-1) = norm(P-p_last) ;
    end
    p_last = P ;
    
end

% plot the deviation of every step iteration
figure(2)
j = 1:tspan-1 ;
plot(j, p_save, '-.r*') ;


%% system equation
function dydt = LTIsys2(t, x)

global A B Q R K ;

%system states
p = x(1:4) ;
v = x(5) ;

u = -K * p ;
dot_x = A * p + B * u ;
dot_v = (p' * Q * p) + (u' * R * u) ;

dydt = [dot_x
    dot_v] ; 

end


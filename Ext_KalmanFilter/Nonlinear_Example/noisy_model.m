function [x,y] = noisy_model(p,R,Q,T_span,u,x0)
%NOISY_MODEL Adds noise to a specific system and signal
%
%   [X,Y] = NOISY_MODEL(P,R,Q,T_SPAN,U,X0) takes a struct P with parameters
%   and constructs, according to these, a discrete time nonlinear system
%   represented by discrete differential equations. The matrices R and Q
%   specify the measurement and the process covariance matrices. In order
%   to simulate the system, the function also takes an input signal U, an
%   initial condition X0 and the simulation time span T_SPAN. The function
%   outputs the noisy states X and the noisy output Y.

[m1,n] = size(Q);
[m2,n] = size(R);
n = length(T_span);
delta_w = randn(m1,n);      % White Gaussian noise for w
delta_v = randn(m2,n);      % White Gaussian noise for v

w = Q*delta_w;              % Process noise
v = R*delta_v;              % Measurement noise

x = zeros(m1,n+1);          % Preallocation of memory for the states
x(:,1) = x0;                % Assigning the initial condition
y = zeros(m2,n);            % Preallocation of memory for the output

for i=1:n
    
    % Calculating system dynamics with discrete differential equations from
    % hell
    x(1,i+1) = x(1,i)+p.T*x(2,i)+w(1,i);
    x(2,i+1) = x(2,i)+p.T*(p.g+p.k/p.m3*(x(3,i)*p.R-x(1,i))+p.b/p.m3*(x(4,i)*p.R-x(2,i)))+w(2,i);
    x(3,i+1) = x(3,i)+p.T*x(4,i)+w(3,i);
    x(4,i+1) = x(4,i)+p.T*((u(i)+p.g*p.d*cos(x(3,i))*(p.m2-p.m1)+p.k*(x(1,i)-x(3,i)*p.R)+p.b*(x(2,i)-x(4,i)*p.R))/(p.c1*p.m1+p.c2*p.m2))+w(4,i);
    
    % Observing the fourth state as an output
    y(i) = x(4,i)+v(i);
end

end



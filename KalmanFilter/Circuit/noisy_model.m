function [x,y] = noisy_model(sys,R,Q,T_span,u)
%NOISY_MODEL NOISY_MODEL(SYS,R,Q,T_SPAN,U) adds white Gaussian noise to a
%system specified through SYS, using the measurement covariance R and the
%process covariance Q. The discrete time vector is specified through T_SPAN
%and the input is given by U.

[m1,n] = size(sys.a);
[m2,n] = size(sys.c);
n = length(T_span);
delta_w = randn(m1,n);
delta_v = randn(m2,n);

w = Q*delta_w;
v = R*delta_v;

x = zeros(m1,n+1);
y = zeros(m2,n);

for i=1:n
    x(:,i+1) = sys.a*x(:,i)+sys.b*u(i)+w(:,i);
    y(i) = sys.c*x(:,i)+sys.d*u(i)+v(:,i);
end

end


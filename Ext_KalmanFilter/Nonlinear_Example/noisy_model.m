function [x,y] = noisy_model(p,R,Q,T_span,u,x0)
%NOISY_MODEL Summary of this function goes here
%   Detailed explanation goes here

[m1,n] = size(Q);
[m2,n] = size(R);
n = length(T_span);
delta_w = randn(m1,n);
delta_v = randn(m2,n);

w = Q*delta_w;
v = R*delta_v;

x = zeros(m1,n+1);
x(:,1) = x0;
y = zeros(m2,n);

for i=1:n
    x(1,i+1) = x(1,i)+p.T*x(2,i)+w(1,i);
    x(2,i+1) = x(2,i)+p.T*(p.g+p.k/p.m3*(x(3,i)*p.R-x(1,i))+p.b/p.m3*(x(4,i)*p.R-x(2,i)))+w(2,i);
    x(3,i+1) = x(3,i)+p.T*x(4,i)+w(3,i);
    x(4,i+1) = x(4,i)+p.T*((u(i)+p.g*p.d*cos(x(3,i))*(p.m2-p.m1)+p.k*(x(1,i)-x(3,i)*p.R)+p.b*(x(2,i)-x(4,i)*p.R))/(p.c1*p.m1+p.c2*p.m2))+w(4,i);
    y(i) = x(4,i)+v(i);
end

end



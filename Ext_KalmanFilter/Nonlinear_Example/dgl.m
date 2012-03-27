function dp = dgl(x,y)
%DGL Summary of this function goes here
%   Detailed explanation goes here
k=100;
b=1;
g=9.81;
m1=1;
m2=5;
m3=2;
R=0.5;
d=1;
c1=1;
c2=1;

dp = zeros(4,1);
dp(1) = y(2);
dp(2) = g+k/m3*(y(3)*R-y(1))+b/m3*(y(4)*R-y(2));
dp(3) = y(4);
dp(4) = (g*d*cos(y(3))*(m2-m1)+k*(y(1)-y(3)*R)+b*(y(2)-y(4)*R))/(c1*m1+c2*m2);

end
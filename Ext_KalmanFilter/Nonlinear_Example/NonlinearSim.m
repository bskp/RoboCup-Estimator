%----------- Parameters -----------%

p.k=30;                       % [N/m]
p.b=2;                        % [Ns/m]
p.g=9.81;                     % [m/s^2]
p.m1=10;                      % [kg]
p.m2=10;                      % [kg]
p.m3=2;                       % [kg]
p.R=0.5;                      % [m]
p.d=1;                        % [m]
p.c1=1;                       % [m^2]
p.c2=1;                       % [m^2]
p.T = 1e-3;                   % Sampling period [s]

steps = round(10/p.T);        % Simulation steps
t = [0:p.T:p.T*steps];          % Timevector for simulation
input = @(x) -19.5+sin(x);     % Input function
u = input(t);               % Inputvector

Q_e = eye(4)*1e-6;          % Process noise covariance
R_e = 1*1e-2;               % Measurement noise covariance


%----------- Differential equations -----------%

f1 = @(x1,x2) x1+p.T*x2;
f2 = @(x1,x2,x3,x4) x2+p.T*(p.g+p.k/p.m3*(x3*p.R-x1)+p.b/p.m3*(x4*p.R-x2));
f3 = @(x3,x4) x3+p.T*x4;
f4 = @(x1,x2,x3,x4,u) x4+p.T*(u+p.g*p.d*cos(x3)*(p.m2-p.m1)+p.k*(x1-x3*p.R)+p.b*(x2-x4*p.R))/(p.c1*p.m1+p.c2*p.m2);


%----------- Computation -----------%

x1 = zeros(4,steps+1);
y1 = zeros(1,steps+1);
x1(:,1) = [0;0;0;0];

for i=1:steps
    x1(1,i+1) = x1(1,i)+p.T*x1(2,i);
    x1(2,i+1) = x1(2,i)+p.T*(p.g+p.k/p.m3*(x1(3,i)*p.R-x1(1,i))+p.b/p.m3*(x1(4,i)*p.R-x1(2,i)));
    x1(3,i+1) = x1(3,i)+p.T*x1(4,i);
    x1(4,i+1) = x1(4,i)+p.T*((u(i)+p.g*p.d*cos(x1(3,i))*(p.m2-p.m1)+p.k*(x1(1,i)-x1(3,i)*p.R)+p.b*(x1(2,i)-x1(4,i)*p.R))/(p.c1*p.m1+p.c2*p.m2));
    y1(i) = x1(4,i);
    %x1(1,i+1) = f1(x1(1,i),x1(2,i));
    %x1(2,i+1) = f2(x1(1,i),x1(2,i),x1(3,i),x1(4,i));
    %x1(3,i+1) = f3(x1(3,i),x1(4,i));
    %x1(4,i+1) = f4(x1(1,i),x1(2,i),x1(3,i),x1(4,i),u(i));
end

subplot(2,2,1)
plot(t,u)

subplot(2,2,2)
plot(t,y1)

[x2,y2] = noisy_model(p,R_e,Q_e,t,u,x1(:,1));
subplot(2,2,3)
plot(t,y2)

y3 = kalman_filter(p,R_e,Q_e,u,y2);
subplot(2,2,4)
plot(t,y3)


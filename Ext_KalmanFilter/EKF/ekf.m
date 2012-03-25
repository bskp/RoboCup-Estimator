%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        %
%%%%         EKF - Nonlinear system: Pendulum         %%%%
%                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Example from Control System I
%Equation of motion for pendulum:
%   (d^2theta)/(dt^2) + g/l * sin(teta) = Tc/(m*l^2)
%{   
States:     x = [teta; (dteta)/dt] = [x1; x2]
State-space form:
            dx/dt = [dteta/dt; -sqrt(g/l)*sin(teta)+Tc/(m*l^2)]
                  = [x2; -sqrt(g/l)*sin(x1)+u] = [f1; f2]

F is the Jacobian of the transfer function due to the involved variables,
in this case these are x1 and x2, therefore F will be a 2 by 2 matrix.
The resulting F depends on time and must be computed for every step that
the system takes.

F is as follows:
F -> df1/dx1 = 0                        df1/dx2 = 1
     df2/dx1 = -sqrt(g/l)*cos(teta)     df2/dx1 = 0
%}
clear all;

g = 9.81;   %[m*s^(-2)]
l = 1;      %[m]
m = 1;      %[kg]
Tc = 1;     %[Nm]

% Initial Conditions
x(:,1) = [pi./2;0];     %Our real plant initial condition       
x_(:,1) = [pi./2;0];    %Our estimate initial conidition (they might differ)
xc = x_;                %Set the ideal model as we think it should start
P = [0.01 0; 0 0.01];   %set initial error covariance for position & frec, both at sigma 0.1, P=diag([sigma_pos_init^2 sigmav_frec_init^2])

sigmav = 0.1;           %the covariance coeficient for the position error, sigma
sigmaw = 0.5;           %the covariance coeficient for the frecuency error, sigma
Q = sigmav.^2;          %the error covariance constant to be used, in this case just a escalar unit
R = sigmaw.^2;          %the error covariance constant to be used, in this case just a escalar unit

G = [0;1];              %G is the Jacobian of the plant tranfer functions due to the error.
H = [1 0];              %H is the Jacobian of the sensor transfer functions due to the variables involved
W = 1;                  %W is the Jacobian of the sensor transfer functions due to the error.

steps = 100;            %Amount of steps to simulate

for i =2:steps          %start @ time=2 
  % the real plant
  x(:,i) = [x(2,i-1) + randn*sigmav; -(g/l)*sin(x(1,i-1)) + Tc/(m*l.^2)];
  z(i) = x(1,i) + randn*sigmaw;

  % blind prediction (just for comparison)
  xc(:,i) = [xc(2,i-1); -(g/l)*sin(xc(1,i-1)) + Tc/(m*l.^2)];
  % prediction
  x_(:,i) = [x_(2,i-1); -(g/l)*sin(x_(1,i-1)) + Tc/(m*l.^2)];
  z_(i) = x_(1,i);

  % compute F
  F = [0 1; -(g/l)*cos(x_(1,i)) 0];
  
  % Prediction of the plant covariance
  P = F*P*F' + G*Q*G';
  % Innovation Covariance
  S = H*P*H'+R;
  % Kalman's gain
  K = P*H'*inv(S);
  % State check up and update
  x_(:,i) = x_(:,i) + K * (z(i)-z_(i));
  
  % Covariance check up and update
  P = (eye(2)-K*H)*P;
  
  sigmaP(:,i)=sqrt(diag(P)); %sigmap is for storing the current error covariance for ploting pourposes
end
  
clf;
hold on;
plot(x(1,:),'-b');                  %plot the real plant behavior
plot(z,'.r');                       %plot the observations over this plant
plot(x_(1,:),'-g');                 %plot the Kalman filter prediction over the plant
plot(xc(1,:),'-m');                 %The original thought of the plant

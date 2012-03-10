%----------- Parameters -----------%

L = 2e-4;                   % [H]
C1 = 1e-6;                  % [F]
C2 = 1e-6;                  % [F]
R = 50;                     % [ohm]
T = 1e-6;                   % Sampling rate [s]

f = 1e5;
input = @(x) sin(f*x);      % Input function
t = [0:T:1e3*T];            % Timevector for simulation
u = input(t);               % Inputvector

Q_e = eye(3)*1e-4;          % Process noise covariance
R_e = 1*1e-1;               % Measurement noise covariance

%----------- Discrete time state space representation -----------%

% Continuous time matrices
A_bar = [0,0,-1/L;0,-R/C1,R/C1;1/C2,R/C2,-R/C2];    
B_bar = [1/L;0;0];
C = [0,0,1];
D = 0;

% Discrete time matrices
A = expm(A_bar*T);
%syms tau
%B = int(expm(A*(T-tau))*B_bar,0,T);
B = 1e-6 * B_bar;

% State space model
sys = ss(A,B,C,D,T);

%----------- Computation -----------%

subplot(2,2,1)
plot(t,u)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Input signal');

y1 = lsim(sys,u,t);
subplot(2,2,2)
plot(t,y1)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Output signal');

[x,y2] = noisy_model(sys,R_e,Q_e,t,u);
subplot(2,2,3)
plot(t,y2)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Noisy output signal');

y3 = kalman_filter(sys,R_e,Q_e,u,y2);
subplot(2,2,4)
plot(t,y3)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Filtered output signal');


%----------- Parameters -----------%

L = 2e-4;                   % [H]
C1 = 1e-6;                  % [F]
C2 = 1e-6;                  % [F]
R = 50;                     % [ohm]
T = 1e-6;                   % Sampling rate [s]

w = 1e5;
input = @(x) exp(-w*x./20).*sin(w*x);     % Input function
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

sys = ss(A_bar,B_bar,C,D);

% Discrete time matrices
A = expm(A_bar*T);
%syms tau
%B = int(expm(A*(T-tau))*B_bar,0,T);
%B = 1e-6 * B_bar
B = inv(A_bar)*(A-ones(3))*B_bar;

% Convert to discrete time matrices
sysd = c2d(sys,T);

%----------- Computation -----------%

subplot(2,2,1)
plot(t,u)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Input signal');

[x_noise,y_measured] = noisy_model(sysd,R_e,Q_e,t,u);
subplot(2,2,2)
plot(t,sysd.c*x_noise+sysd.d*u)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Output signal');

subplot(2,2,3)
plot(t,y_measured)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Measured output signal');

y_filtered = kalman_filter(sysd,R_e,Q_e,u,y_measured);
subplot(2,2,4)
plot(t,y_filtered)
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Filtered output signal');

[x_true_B,y_true] = true_model(sysd,t,u);

norm(y_filtered-y_true)

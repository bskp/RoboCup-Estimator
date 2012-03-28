function y = kalman_filter(p,R,Q,u,y_hat)
%KALMAN_FILTER Denoises a signal for given parameters
%
%   Y = KALMAN_FILTER(P,R,Q,U,Y_HAT) takes a noisy signal Y_HAT and
%   estimates the real signal by applying a discrete extended Kalman
%   filter. The parameters R and Q represent the measurement and the
%   process covariance matrices respectively. U is the input signal whereas
%   P represents a struct where all model-relevant parameters are stored.

%----------- Init -----------%

[m,n] = size(Q);
x_apr = ones(n,1);      % Random initial conditions for estimation
P_apriori = eye(n);     % Random initial P matrix for estimation
I = eye(n);

A(1,:) = [0,1,0,0];
A(2,:) = [-p.k/p.m3,-p.b/p.m3,p.k*p.R/p.m3,p.b*p.R/p.m3];
A(3,:) = [0,0,0,1];
A(4,:) = [p.k,p.b,-p.k*p.R,-p.b*p.R]/(p.c1*p.m1+p.c2*p.m2);

A=eye(n)+p.T*A;     % Linearization of system dynamics with respect to x

C = [0,0,0,1];      % Linearization of output dynamics with respect to x

W = eye(n);         % Linearization of system dynamics with respect to w

V = 1;              % Linearization of output dynamics with respect to v

%----------- Step -----------%
% Algorithm taken from kalman_intro.pdf

for i=1:length(u)
    
    % Time update (predict, with discrete differential equations from hell)
    x_apr(1) = x_apr(1)+p.T*x_apr(2);
    x_apr(2) = x_apr(2)+p.T*(p.g+p.k/p.m3*(x_apr(3)*p.R-x_apr(1))+p.b/p.m3*(x_apr(4)*p.R-x_apr(2)));
    x_apr(3) = x_apr(3)+p.T*x_apr(4);
    x_apr(4) = x_apr(4)+p.T*((u(i)+p.g*p.d*cos(x_apr(3))*(p.m2-p.m1)+p.k*(x_apr(1)-x_apr(3)*p.R)+p.b*(x_apr(2)-x_apr(4)*p.R))/(p.c1*p.m1+p.c2*p.m2));
    P_apriori = A*P_apriori*A'+W*Q*W';
    
    % Measurement update (correct)
    K = (P_apriori*C')/(C*P_apriori*C'+V*R*V');
    x_apr = x_apr+K*(y_hat(:,i)-x_apr(4));
    P_apriori = (I-K*C)*P_apriori;
    
    % Estimated output (We are estimating the angular velocity)
    y(:,i) = x_apr(4);
end
end


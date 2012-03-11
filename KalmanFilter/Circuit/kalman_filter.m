function y = kalman_filter(sys,R,Q,u,y_hat)
%KALMAN_FILTER KALMAN_FILTER(SYS,R,Q,U,V,Y_HAT) takes a discrete LTI-
% System SYS and the noise covariances R and Q for the measurement and the
% process respectively. By using a Kalman-Filter, the function returns an
% estimate of the output of SYS to a given input U and a noisy output
% Y_HAT.

%----------- Init -----------%

[m,n] = size(sys.a);
x_apriori = zeros(n,1);
P_apriori = eye(n);
I = eye(n);

%----------- Step -----------%
% Algorithm taken from kalman_intro.pdf
for i=1:length(u)
    % Time update (predict)
    x_apriori = sys.a*x_apriori+sys.b*u(:,i);
    P_apriori = sys.a*P_apriori*sys.a'+Q;
    
    % Measurement update (correct)
    K = (P_apriori*sys.c')/(sys.c*P_apriori*sys.c'+R);
    x_apriori = x_apriori+K*(y_hat(:,i)-sys.c*x_apriori);
    P_apriori = (I-K*sys.c)*P_apriori;
    
    % Estimated output
    y(:,i) = sys.c*x_apriori;
end

end


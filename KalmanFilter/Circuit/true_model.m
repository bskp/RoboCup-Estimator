function [x,y] = true_model(sys,T_span,u)
%NOISY_MODEL NOISY_MODEL(SYS,R,Q,T_SPAN,U) adds white Gaussian noise to a
%system specified through SYS, using the measurement covariance R and the
%process covariance Q. The discrete time vector is specified through T_SPAN
%and the input is given by U.

    [m,n] = size(sys.a);
    [p,n] = size(sys.c);
    t = length(T_span);

    x = zeros(m,t);
    y = zeros(p,t);
    

    for i=1:t-1
        x(:,i+1) = sys.a*x(:,i) + sys.b*u(i);
    end
    
    for i=1:t
        y(i) = sys.c*x(:,i) + sys.d*u(i);
    end
end


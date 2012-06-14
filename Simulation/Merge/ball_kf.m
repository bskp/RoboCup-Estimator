function [Ball_e P_e] = ball_kf(Ball_oe, Ball_m, P_oe)
%BALL_KF Applies Kalman filtering to the ball's measurements.
%
%   [BALL_E,P_E] = BALL_KF(BALL_OE,BALL_M,P_OE) is an extended Kalman
%   filter for the ball object on the field. The function takes the
%   parameters BALL_OE, the estimates of the previous Kalman cycle and
%   BALL_M, the measurements and computes the new estimates BALL_E. P_EO
%   and P_E denote the error covariance matrices of the old and the new
%   estimates respectively. The function also takes rapid changes of the
%   ball's motion, like boundary collisions, into account.
%   
%   Indices:
%   _m:  measurement
%   _oe: old estimation
%   _:   a priori ("super minus" in the paper)
%

    global BallParam;
    global Noise;
    
%--------- Handle a discrete event (like a boundary collision)  ---------%
    
    x_oe = [Ball_oe.x ; Ball_oe.y ; Ball_oe.dir];
    x_m = [Ball_m.x ; Ball_m.y ; Ball_m.dir;];

    if(norm(x_oe(1:2)-x_m(1:2))>0.5 || abs(x_oe(3)-x_m(3))>pi/2)
        P_oe = eye(4);
    end
    
    
%--------- Init of covariance matrices and linearized matrices  ---------%
   
    Q = diag( [Noise.Process.pos.^2, Noise.Process.pos.^2, Noise.Process.dir.^2, 0] );
    R = diag( [Noise.Measure.pos.^2, Noise.Measure.pos.^2, Noise.Measure.dir.^2] );
    H = [1,0,0,0;0,1,0,0;0,0,1,0];  
    x_ = [0;0;0;0];      

    A = [1 0 -BallParam.velocity*Ball_oe.velocity*sin(x_oe(3)) BallParam.velocity*cos(x_oe(3));
      0 1 BallParam.velocity*Ball_oe.velocity*cos(x_oe(3)) BallParam.velocity*sin(x_oe(3));
      0 0 1 0 ;
      0 0 0 BallParam.friction];

    
%--------- Kalman cycle  ---------%    
    
    % Time update (predict)
    x_(1) = x_oe(1) + BallParam.velocity*Ball_oe.velocity*cos(x_oe(3));
    x_(2) = x_oe(2) + BallParam.velocity*Ball_oe.velocity*sin(x_oe(3));
    x_(3) = Ball_oe.dir;
    x_(4) = Ball_oe.velocity*BallParam.friction;

    P_ = A*P_oe*A'+Q;

    % Measurement update (correct)
    z = [Ball_m.x; Ball_m.y; Ball_m.dir];
    %z = [ Ball_m.x;
    %      Ball_m.y;
    %      atan( (Ball_m.y-Ball_oe.y) / ( Ball_m.x-Ball_oe.x) ); %crappy, I know
    %      x_(3)     ]; % assume velocity as perfectly measured (see also
    %      Q, R)
    if (isnan(z(1) * z(2)))
        x = x_;      % Measurement drop 
        P_e = P_;
    else
        K = P_*H'/(H*P_*H'+R);
        x = x_ + K*(z - H*x_);
        P_e = (eye(4) - K*H)*P_;
    end

    % Assemble output

    Ball_e.x = x(1);
    Ball_e.y = x(2);
    Ball_e.dir = x(3);
    Ball_e.velocity = x(4);

end


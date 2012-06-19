function [BallEstimate Pe KBnorm] = ball_ekf(BallOe, BallMeasure, Poe)
%BALL_EKF Applies Extended Kalman filtering to the ball's measurements.
%
%   [BALLESTIMATE,PE] = BALL_EKF(BALLOE,BALLMEASURE,POE) is an extended
%   Kalman filter for the ball object on the field. The function takes the
%   parameters BALLOE, the estimates of the previous Kalman cycle and
%   BALLMEASURE, the measurements and computes the new estimates
%   BALLESTIMATE. PEO and PE denote the error covariance matrices of the
%   old and the new estimates respectively. The function also takes rapid
%   changes of the ball's motion, like boundary collisions, into account.
%   
%   Indices:
%   _m:  measurement
%   _oe: old estimation
%   _:   a priori ("super minus" in the paper)
%

    global BallParam;
    global Noise;
    
%--------- Handle a discrete event (like a boundary collision)  ---------%
    
    xOe = [BallOe.x ; BallOe.y ; BallOe.dir];
    xMeasure = [BallMeasure.x ; BallMeasure.y ; BallMeasure.dir;];

    if(norm(xOe(1:2) - xMeasure(1:2))>0.5 || abs(xOe(3) - xMeasure(3))>pi/2)
        Poe = eye(4);
    end
    
    
%--------- Init of covariance matrices and linearized matrices  ---------%
   
    Q = diag( [Noise.Process.pos.^2, Noise.Process.pos.^2, Noise.Process.dir.^2, 0] );
    R = diag( [Noise.Measure.pos.^2, Noise.Measure.pos.^2, Noise.Measure.dir.^2] );
    H = [1,0,0,0;0,1,0,0;0,0,1,0];  
    x_ = [0;0;0;0];      

    A = [1 0 -BallParam.velocity*BallOe.velocity*sin(xOe(3)) BallParam.velocity*cos(xOe(3));
      0 1 BallParam.velocity*BallOe.velocity*cos(xOe(3)) BallParam.velocity*sin(xOe(3));
      0 0 1 0 ;
      0 0 0 BallParam.friction];

    
%--------- Kalman cycle  ---------%    
    
    % Time update (predict)
    x_(1) = xOe(1) + BallParam.velocity*BallOe.velocity*cos(xOe(3));
    x_(2) = xOe(2) + BallParam.velocity*BallOe.velocity*sin(xOe(3));
    x_(3) = BallOe.dir;
    x_(4) = BallOe.velocity*BallParam.friction;

    P_ = A*Poe*A'+Q;

    % Measurement update (correct)
    z = [BallMeasure.x; BallMeasure.y; BallMeasure.dir];
    %z = [ Ball_m.x;
    %      Ball_m.y;
    %      atan( (Ball_m.y-Ball_oe.y) / ( Ball_m.x-Ball_oe.x) ); %crappy, I know
    %      x_(3)     ]; % assume velocity as perfectly measured (see also
    %      Q, R)
    if (isnan(z(1) * z(2)))
        x = x_;      % Measurement drop 
        Pe = P_;
        KBnorm = NaN;
    else
        K = P_*H'/(H*P_*H'+R);
        KBnorm = norm(K);
        x = x_ + K*(z - H*x_);
        Pe = (eye(4) - K*H)*P_;
    end

    % Assemble output

    BallEstimate.x = x(1);
    BallEstimate.y = x(2);
    BallEstimate.dir = x(3);
    BallEstimate.velocity = x(4);
end
function [Ball_e P_e] = ball_kf( Ball_oe, Ball_m, P_oe )
%BALL_KF Applies Kalman filtering to the ball's measurements
%   Indices:
%   _m:  measurement
%   _oe: old estimation
%   _:   a priori ("super minus" in the paper)
%

global BallParam;
global Noise;

% LE MODEL
x_oe =  [ Ball_oe.x ;
          Ball_oe.y ;
          Ball_oe.dir;
          Ball_oe.velocity ];

A = [ 1 0 0 cos(Ball_oe.dir) ;
      0 1 0 sin(Ball_oe.dir) ;
      0 0 1 0 ;
      0 0 0 BallParam.friction ];

% COVARIANCE MATRICES
Q = diag( [Noise.process.pos, Noise.process.pos, Noise.process.dir 0] );
R = diag( [Noise.measure.pos, Noise.measure.pos, Noise.measure.dir 0] );
H = eye(4);

% ESTIMATION
x_ = A*x_oe;
P_ = A*P_oe*A'+Q;

% CORRECTION
z = [ Ball_m.x;
      Ball_m.y;
      atan( (Ball_m.y-Ball_oe.y) / ( Ball_m.x-Ball_oe.x) ); %crappy, I know
      x_(3)     ]; % assume velocity as perfectly measured (see also Q, R)

K = P_*H'/(H*P_*H'+R);
x = x_ + K*(z - H*x_);

P_e = (eye(4) - K*H)*P_;


% Assemble output

Ball_e.x = x(1);
Ball_e.y = x(2);
Ball_e.dir = x(3);
Ball_e.velocity = x(4);

end


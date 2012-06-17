function Ball = ball_init()
%BALL_INIT Initializes a new ball.
%
%   BALL = BALL_INIT() creates a struct with ball-specific parameters, i.e.
%   its position, direction and velocity. Furthermore important global
%   variables are defined such as its radius on the field and the friction
%   of the ground.


%----------- Init of global variables -----------%

    global BallParam dt;
    BallParam.radius = 0.05; %[m]
    BallParam.velocity = 0.4 *dt; %[m/s]
    BallParam.friction = 0.995;

    
%----------- Init of ball parameters -----------%
    
    Ball =  struct('x',0,'y',0,'dir',pi./2,'velocity',1);

end
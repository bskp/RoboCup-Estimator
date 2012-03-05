function Ball = ball_init()
%BALL_INIT
    global BallParam;
    BallParam.radius = 0.05; %[m]
    BallParam.firction = 0.995;

     Ball =  struct('x',0,'y',0,'dir',pi./2,'velocity',1);

end


function BallStep = ball_step(Ball,Robot)
%BALL_STEP Simulates the movement of the ball for one timestep.
%
%   BALLSTEP = BALL_STEP(BALL,ROBOT) takes the parameters BALL and ROBOT
%   and calculates, according to the position of the ball and the robots on
%   the field, the next position of the ball and its velocity. A new
%   ball-object with these parameters is created as output.

    global BallParam;
    global RobotParam;
    global Noise;
    
%----------- Ball dynamics -----------%

    BallStep.x = BallParam.velocity * Ball.velocity * cos(Ball.dir) + Ball.x;
    BallStep.y = BallParam.velocity * Ball.velocity * sin(Ball.dir) + Ball.y;
    BallStep.dir = Ball.dir;
    BallStep.velocity = Ball.velocity * BallParam.friction;
    
    % Process noise, same as for robots
    BallStep.x = BallStep.x + randn*Noise.Process.pos;
    BallStep.y = BallStep.y + randn*Noise.Process.pos;
    BallStep.dir = BallStep.dir + randn*Noise.Process.dir;
    
%----------- Checking collision with field boundaries -----------%

    if abs(BallStep.x) > 3 - BallParam.radius
         BallStep.dir = pi - Ball.dir;
         BallStep.x = BallParam.velocity * Ball.velocity * ...
             cos(BallStep.dir) + Ball.x;
         BallStep.y = BallParam.velocity * Ball.velocity * ...
             sin(BallStep.dir) + Ball.y;
         scorecounter;
    end
    if abs(BallStep.y) > 2 - BallParam.radius
         BallStep.dir = -Ball.dir;
         BallStep.x = BallParam.velocity * Ball.velocity * ...
             cos(BallStep.dir) + Ball.x;
         BallStep.y = BallParam.velocity * Ball.velocity * ...
             sin(BallStep.dir) + Ball.y;
    end
    
    
%----------- Checking collision with robots -----------%

    for i=1:8
        dX = Ball.x - Robot(i).x;
        dY = Ball.y - Robot(i).y;
        if (dX.^2 + dY.^2 < (RobotParam.radius + BallParam.radius).^2)
            BallStep.dir = angle(dX + dY*j);
            BallStep.velocity = 1;
            BallStep.x = BallParam.velocity * Ball.velocity * ...
                cos(BallStep.dir) + Ball.x;
            BallStep.y = BallParam.velocity * Ball.velocity * ...
                sin(BallStep.dir) + Ball.y;
        end
    end
end
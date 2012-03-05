function BallStep = ball_step(Ball,Robot)
%BALL_STEP

    global BallParam;
    global RobotParam;

    BallStep.x = BallParam.velocity * Ball.velocity * cos(Ball.dir) + Ball.x;
    BallStep.y = BallParam.velocity * Ball.velocity * sin(Ball.dir) + Ball.y;
    BallStep.dir = Ball.dir;
    BallStep.velocity = Ball.velocity * BallParam.firction;
    
    % Boundaries collision
    if abs(BallStep.x) > 3 - BallParam.radius
         BallStep.dir = pi - Ball.dir;
         BallStep.x = BallParam.velocity * Ball.velocity * cos(BallStep.dir) + Ball.x;
         BallStep.y = BallParam.velocity * Ball.velocity * sin(BallStep.dir) + Ball.y;
    end
    if abs(BallStep.y) > 2 - BallParam.radius
         BallStep.dir = -Ball.dir;
         BallStep.x = BallParam.velocity * Ball.velocity * cos(BallStep.dir) + Ball.x;
         BallStep.y = BallParam.velocity * Ball.velocity * sin(BallStep.dir) + Ball.y;
    end
    
    % Robot collison
    for i=1:8
        dX = Ball.x - Robot(i).x;
        dY = Ball.y - Robot(i).y;
        if (dX.^2 + dY.^2 < (RobotParam.radius + BallParam.radius).^2)
            BallStep.dir = angle(dX + dY*j);
            BallStep.velocity = 1;
            BallStep.x = BallParam.velocity * Ball.velocity * cos(BallStep.dir) + Ball.x;
            BallStep.y = BallParam.velocity * Ball.velocity * sin(BallStep.dir) + Ball.y;
        end
end


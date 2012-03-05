function BallStep = ball_step(Ball,Robot)
%BALL_STEP

    global BallParam;

    BallStep.x = BallParam.velocity * Ball.velocity * cos(Ball.dir) + Ball.x;
    BallStep.y = BallParam.velocity * Ball.velocity * sin(Ball.dir) + Ball.y;
    BallStep.dir = Ball.dir;
    BallStep.velocity = Ball.velocity* BallParam.firction;
    
%     % Bondaries Collision
%     if abs(Ball.x) > 3 - 0.05
%          BallStep.dir = pi - Ball.dir;
%          BallStep.dir = BallParam.velocity * Ball.V * cos(BallOut.Theta) + Ball.X;
%          BallStep.dor = v_ball * Ball.V * sin(BallOut.Theta) + Ball.Y;
%      end
%          
%      if abs(Ball.Y) > 2-0.05
%          BallOut.Theta = -Ball.Theta;
%          BallOut.X = v_ball * Ball.V * cos(BallOut.Theta) + Ball.X;
%          BallOut.Y = v_ball * Ball.V * sin(BallOut.Theta) + Ball.Y;
%      end
%      
%      for i=1:3
%         dXR = Ball.X - RedRobots(i).X;
%         dYR = Ball.Y - RedRobots(i).Y;
%         if dXR.^2 + dYR.^2 < 0.04
%             BallOut.Theta = angle(dXR + i*dYR);
%             BallOut.V = 1;
%             BallOut.X = v_ball * BallOut.V * cos(BallOut.Theta) + Ball.X;
%             BallOut.Y = v_ball * BallOut.V * sin(BallOut.Theta) + Ball.Y;
%         end
%         dXB = Ball.X - BlueRobots(i).X;
%         dYB = Ball.Y - BlueRobots(i).Y;
%         if dXB.^2 + dYB.^2 < 0.04
%             BallOut.Theta = angle(dXB + i*dYB);
%             BallOut.V = 1;
%             BallOut.X = v_ball * BallOut.V * cos(BallOut.Theta) + Ball.X;
%             BallOut.Y = v_ball * BallOut.V * sin(BallOut.Theta) + Ball.Y;
%         end

end


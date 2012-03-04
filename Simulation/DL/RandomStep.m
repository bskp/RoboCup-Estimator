function [RedRobotsOut,BlueRobotsOut,BallOut] = RandomStep(RedRobots,BlueRobots,Ball)
%RANDOMSTEP

% Parameters
    v_robot = 0.01;
    v_ball = 0.04;
    omega = rand(1,6)-0.5*ones(1,6);
    k = pi./6;
    
    for i=1:3
       RedRobotsOut(i).X = v_robot * cos(RedRobots(i).Theta) + RedRobots(i).X;
       RedRobotsOut(i).Y = v_robot * sin(RedRobots(i).Theta) + RedRobots(i).Y;
       RedRobotsOut(i).Theta = omega(i)*k + RedRobots(i).Theta;
       
       BlueRobotsOut(i).X = v_robot * cos(BlueRobots(i).Theta) + BlueRobots(i).X;
       BlueRobotsOut(i).Y = v_robot * sin(BlueRobots(i).Theta) + BlueRobots(i).Y;
       BlueRobotsOut(i).Theta = omega(i+3)*k + BlueRobots(i).Theta;
       
       %Tests
       if abs(RedRobotsOut(i).X) > 3-0.15
           RedRobotsOut(i).Theta = pi - RedRobots(i).Theta;
           RedRobotsOut(i).X = v_robot * cos(RedRobotsOut(i).Theta) + RedRobots(i).X;
           RedRobotsOut(i).Y = v_robot * sin(RedRobotsOut(i).Theta) + RedRobots(i).Y;
       end
       if abs(RedRobotsOut(i).Y) > 2-0.15
           RedRobotsOut(i).Theta = -RedRobots(i).Theta;
           RedRobotsOut(i).X = v_robot * cos(RedRobotsOut(i).Theta) + RedRobots(i).X;
           RedRobotsOut(i).Y = v_robot * sin(RedRobotsOut(i).Theta) + RedRobots(i).Y;
       end
       if abs(BlueRobotsOut(i).X) > 3-0.15
           BlueRobotsOut(i).Theta = pi - BlueRobots(i).Theta;
           BlueRobotsOut(i).X = v_robot * cos(BlueRobotsOut(i).Theta) + BlueRobots(i).X;
           BlueRobotsOut(i).Y = v_robot * sin(BlueRobotsOut(i).Theta) + BlueRobots(i).Y;
       end
       if abs(BlueRobotsOut(i).Y) > 2-0.15
           BlueRobotsOut(i).Theta = -BlueRobots(i).Theta;
           BlueRobotsOut(i).X = v_robot * cos(BlueRobotsOut(i).Theta) + BlueRobots(i).X;
           BlueRobotsOut(i).Y = v_robot * sin(BlueRobotsOut(i).Theta) + BlueRobots(i).Y;
       end
    end
    
    BallOut.X = v_ball * Ball.V * cos(Ball.Theta) + Ball.X;
    BallOut.Y = v_ball * Ball.V * sin(Ball.Theta) + Ball.Y;
    BallOut.Theta = Ball.Theta;
    BallOut.V = Ball.V * 0.99;
    % Tests
     if abs(Ball.X) > 3 - 0.05
         BallOut.Theta = pi - Ball.Theta;
         BallOut.X = v_ball * Ball.V * cos(BallOut.Theta) + Ball.X;
         BallOut.Y = v_ball * Ball.V * sin(BallOut.Theta) + Ball.Y;
     end
         
     if abs(Ball.Y) > 2-0.05
         BallOut.Theta = -Ball.Theta;
         BallOut.X = v_ball * Ball.V * cos(BallOut.Theta) + Ball.X;
         BallOut.Y = v_ball * Ball.V * sin(BallOut.Theta) + Ball.Y;
     end
    
end


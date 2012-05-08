function [RobotStep d_omega velocity] = robot_step(Robot, Ball)
%ROBOT_STEP Simulates the movement of all robots for one timestep.
%
%   [ROBOTSTEP,D_OMEGA,VELOCITY] = ROBOT_STEP(ROBOT) takes all robot
%   structs as parameters and computes the next position of the robots on
%   the field, i.e. generates new structs. The function also outputs the
%   input values D_OMEGA, the change of the angular direction, and
%   VELOCITY, the velocity of a robot, for every robot. These inputs will
%   be of further use with the extended Kalman filter.

    global RobotParam dt;

    
%----------- Inputs  -----------%

    d_omega = randn(8,1) * RobotParam.changeOfDir;
    velocity = ones(8,1) * 0.1 * dt; %[m/s]

%----------- Behavior of Robots  -----------%
    % Only Robots with in the radius of r_a affect the robot
    r_a = 100; % [m]
    for i=1:8
        % Initialize the resulting vector
        x_v = 0;
        y_v = 0;
        % Other robots
        for j=1:8
            % Length of the vectors
            r = sqrt((Robot(j).x-Robot(i).x).^2+(Robot(j).y-Robot(i).y).^2);
            
            % New coordinate system
            if (i~=j && (r<=r_a))
                if ((x_v==0) && (y_v==0))
                    x_v = (Robot(j).x-Robot(i).x)./r;
                    y_v = (Robot(j).y-Robot(i).y)./r;
                else
                    x_v = x_v + (Robot(j).x-Robot(i).x)./r;
                    y_v = y_v + (Robot(j).y-Robot(i).y)./r;
                end
            end
        end
        % Ball
        x_n = -x_v + (Ball.x-Robot(i).x);
        y_n = -y_v + (Ball.y-Robot(i).y);

        
        % I quadrant
        if (x_n>=0 && y_n>=0)
                dir(i) = atan(y_n./x_n);
            end
            % II quadrant
            if (x_n<0 && y_n>=0)
                dir(i) = pi - atan(y_n./x_n);
            end
            % III quadrant
            if (x_n<0 && y_n<0)
                dir(i) = pi + atan(y_n./x_n);
            end
            % IV quadrant
            if (x_n>=0 && y_n<0)
                dir(i) = 2*pi - atan(y_n./x_n);
            end     
            %dir(i)
            RobotStep(i).color = Robot(i).color;
            RobotStep(i).x = velocity(i) * cos(dir(i)) + Robot(i).x;
            RobotStep(i).y = velocity(i) * sin(dir(i)) + Robot(i).y;
            RobotStep(i).dir = dir(i);
    end
        
%         for j=1:8
%             % Length of the vectors
%             r = sqrt((Robot(j).x-Robot(i).x).^2+(Robot(j).y-Robot(i).y).^2);
%             if (i~=j && (r<=r_a))
%                 if ((x_n==0) && (y_n==0))
%                     x_n = (Robot(j).x-Robot(i).x)./r;
%                     y_n = (Robot(j).y-Robot(i).y)./r;
%                 else
%                     x_n = x_n + (Robot(j).x-Robot(i).x)./r;
%                     y_n = y_n + (Robot(j).y-Robot(i).y)./r;
%                 end
%             end
%         end
%         x_n = -x_n + Ball.x;
%         y_n = -y_n + Ball.y;
        
        
        
%         if (x_n~=0)
%             
%             % I quadrant
%             if (x_n>=0 && y_n>=0)
%                 dir(i) = atan(y_n./x_n);
%             end
%             % II quadrant
%             if (x_n<0 && y_n>=0)
%                 dir(i) = pi - atan(y_n./x_n);
%             end
%             % III quadrant
%             if (x_n<0 && y_n<0)
%                 dir(i) = pi + atan(y_n./x_n);
%             end
%             % IV quadrant
%             if (x_n>=0 && y_n<0)
%                 dir(i) = 2*pi - atan(y_n./x_n);
%             end     
%             %dir(i)
%             RobotStep(i).color = Robot(i).color;
%             RobotStep(i).x = velocity(i) * cos(dir(i)) + Robot(i).x;
%             RobotStep(i).y = velocity(i) * sin(dir(i)) + Robot(i).y;
%             RobotStep(i).dir = dir(i);
%         else
%             RobotStep(i).color = Robot(i).color;
%             RobotStep(i).x = velocity(i) * cos(Robot(i).dir) + Robot(i).x;
%             RobotStep(i).y = velocity(i) * sin(Robot(i).dir) + Robot(i).y;
%             RobotStep(i).dir = d_omega(i) + Robot(i).dir;           
%         end
%     end
    
%----------- Motion equations for robots  -----------%

%     for i=1:8
%         RobotStep(i).color = Robot(i).color;
%         RobotStep(i).x = velocity(i) * cos(Robot(i).dir) + Robot(i).x;
%         RobotStep(i).y = velocity(i) * sin(Robot(i).dir) + Robot(i).y;
%         RobotStep(i).dir = d_omega(i) + Robot(i).dir;
%     end
    
    
%----------- Adding process noise  -----------%

    global Noise;
    d = randn(8,3);
    
    for i=1:8
        RobotStep(i).color = RobotStep(i).color;
        RobotStep(i).x = RobotStep(i).x + d(i,1) * Noise.process.pos;
        RobotStep(i).y = RobotStep(i).y + d(i,2) * Noise.process.pos;
        RobotStep(i).dir =  RobotStep(i).dir + d(i,3) * Noise.process.dir;
    end
    
    
%----------- Collision detection  -----------%
    
%     for i = 1:8  
%         
%         % Robot collision
%         for j = (i+1):8
%             d = sqrt( (Robot(i).x-Robot(j).x)^2+(Robot(i).y-Robot(j).y)^2);
%             if (d < 2*RobotParam.radius)
%                 d = Robot(i).dir;
%                 RobotStep(i).dir = Robot(j).dir;    % Swapping the
%                 RobotStep(j).dir = d;               % directions
%                 
%                 % Step towards new direction
%                 RobotStep(i).x = velocity(i) * 2 * cos(RobotStep(i).dir) + RobotStep(i).x;
%                 RobotStep(i).y = velocity(i) * 2 * sin(RobotStep(i).dir) + RobotStep(i).y;
%                 RobotStep(j).x = velocity(i) * 2 * cos(RobotStep(j).dir) + RobotStep(j).x;
%                 RobotStep(j).y = velocity(i) * 2 * sin(RobotStep(j).dir) + RobotStep(j).y;
%             end
%         end
%         
%         % Boundaries collision, floor and ceil
%         if abs(RobotStep(i).x) > 3 - RobotParam.radius
%             RobotStep(i).dir = pi - Robot(i).dir;
%             RobotStep(i).x = velocity(i) * cos(RobotStep(i).dir) + Robot(i).x;
%             RobotStep(i).y = velocity(i) * sin(RobotStep(i).dir) + Robot(i).y;
%         end
%         
%         % Boundaries collision, sides
%         if abs(RobotStep(i).y) > 2 - RobotParam.radius
%             RobotStep(i).dir = -Robot(i).dir;
%             RobotStep(i).x = velocity(i) * cos(RobotStep(i).dir) + Robot(i).x;
%             RobotStep(i).y = velocity(i) * sin(RobotStep(i).dir) + Robot(i).y;
%         end
%     end
    
end


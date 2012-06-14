function [RobotStep d_angle velocity] = robot_step(Robot, Ball)
%ROBOT_STEP Simulates the movement of all robots for one timestep.
%
%   [ROBOTSTEP,D_OMEGA,VELOCITY] = ROBOT_STEP(ROBOT) takes all robot
%   structs as parameters and computes the next position of the robots on
%   the field, i.e. generates new structs. The function also outputs the
%   input values D_ANGLE, the change of the angular direction, and
%   VELOCITY, the velocity of a robot, for every robot. These inputs will
%   be of further use with the extended Kalman filter. The function also
%   handles the collision avoidance with other robots and boundary
%   conditions.

    global RobotParam Field;
    
%----------- Inputs  -----------%

    d_omega = randn(8,1) * RobotParam.changeOfDir;
    velocity = ones(8,1) * RobotParam.velocity; %[m/s]

    
%----------- Behavior of Robots  -----------%
    % Only robots within the radius of r_a affect an other robot
    r_a = 0.75; % [m]
    
    % A robot with a distance less than r_f to the border gets repulsed.
    r_f = 2*RobotParam.radius; % [m]
    
    for i=1:8
        % Initialize the resulting vector
        x_v = 0;
        y_v = 0;
        % Weight of nominal direction
        weight = 10;
        % Other robots
        for j=1:8
           % Length of the vector
           r = sqrt((Robot(j).x-Robot(i).x).^2+(Robot(j).y-Robot(i).y).^2);
            
           % Potential function to compute repulsion between robots. If
           % the distance between two robots is r_a, we have unit repuls-
           % ion.
           if (i~=j && (r<=r_a))
               x_v = x_v + (Robot(i).x-Robot(j).x)./r.^3.*r_a.^2;
               y_v = y_v + (Robot(i).y-Robot(j).y)./r.^3.*r_a.^2;
           end
        end
        
        % Compute repulsion if robot is near to one of the side lines.
        if(Field.width/2-abs(Robot(i).x) < r_f)
            r = Field.width/2-abs(Robot(i).x);
            x_v = x_v - sign(Robot(i).x)/r.^2.*r_f.^2;
        end
        
        % Compute repulsion if robot is near to the top or the bottom line.
        if(Field.height/2-abs(Robot(i).y) < r_f)
            r = Field.height/2-abs(Robot(i).y);
            y_v = y_v - sign(Robot(i).y)/r.^2.*r_f.^2;
        end
             
        % Potential function to compute attraction to the ball. In order to
        % avoid collisions between robots, the ball is less attractive than
        % the robots are repulsive.
        r = sqrt((Ball.x-Robot(i).x).^2+(Ball.y-Robot(i).y).^2);
        if (r<=r_a)
            x_v = x_v + (Ball.x-Robot(i).x)./r.^3.*r_a.^2/2;
            y_v = y_v + (Ball.y-Robot(i).y)./r.^3.*r_a.^2/2;
        end
        
        % Nominal directions
        x_n = cos(Robot(i).dir+d_omega(i))*weight;
        y_n = sin(Robot(i).dir+d_omega(i))*weight;
        
        % Motion equations for robots
        RobotStep(i).color = Robot(i).color;
        RobotStep(i).x = velocity(i) * cos(Robot(i).dir) + Robot(i).x;
        RobotStep(i).y = velocity(i) * sin(Robot(i).dir) + Robot(i).y;
        
        %Direction in I & IV quadrant
        RobotStep(i).dir = atan((y_n+y_v)./(x_n+x_v));
        
        %Direction in II & III quadrant
        if((x_n+x_v) < 0)
            RobotStep(i).dir = pi+RobotStep(i).dir;
        end
        
        % Relative change of direction
        d_angle(i) = RobotStep(i).dir-Robot(i).dir;
        
    end
    
    
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


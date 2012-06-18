function [RobotStep dAngle velocity] = robot_randpot_step(Robot, Ball)
%ROBOT_RANDPOT_STEP Simulates the movement of all robots for one timestep.
%
%   [ROBOTSTEP,DANGLE,VELOCITY] = ROBOT_RANDPOT_STEP(ROBOT,BALL) takes all
%   robot structs as parameters and computes the next position of the
%   robots on the field, i.e. generates new structs. The function also 
%   outputs the input values DANGLE, the change of the angular direction, 
%   and VELOCITY, the velocity of a robot, for every robot. These inputs 
%   will be of further use with the extended Kalman filter. The function 
%   also handles collisions with other robots and the boundaries by using
%   collision avoidance. In contrary to former versions, collisions are now
%   not possible anymore.

    global RobotParam Field;
    
%----------- Inputs  -----------%

    dOmega = randn(8,1) * RobotParam.changeOfDir; %[rad/(step*s)]
    velocity = ones(8,1) * RobotParam.velocity; %[m/s]

    
%----------- Behavior of Robots  -----------%

    % Only robots within the radius of ra affect an other robot
    ra = 5*RobotParam.radius; % [m]
    
    % A robot with a distance less than rf to the border gets repulsed.
    rf = 2*RobotParam.radius; % [m]
    
    for i=1:8
        % Initialize the resulting vector
        dx = 0;
        dy = 0;
        % Weight of nominal direction
        C = 0.3*ra;
        % Other robots
        for j=1:8
           % Distance between robot i and j
           r = sqrt((Robot(j).x-Robot(i).x).^2+(Robot(j).y-Robot(i).y).^2);
            
           % Potential function to compute repulsion between robots.
           if ( i~=j && (r <= ra) )
               dx = dx + C./r.^2*(Robot(i).x-Robot(j).x);
               dy = dy + C./r.^2*(Robot(i).y-Robot(j).y);
           end
        end
        
        % Compute repulsion if robot is near to one of the side lines.
        if( Field.width/2-abs(Robot(i).x) < rf )
            r = Field.width/2-abs(Robot(i).x);
            dx = dx - C*sign(Robot(i).x)/r.^2*rf.^2;
        end
        
        % Compute repulsion if robot is near to the top or the bottom line.
        if( Field.height/2-abs(Robot(i).y) < rf )
            r = Field.height/2-abs(Robot(i).y);
            dy = dy - C*sign(Robot(i).y)/r.^2.*rf.^2;
        end
             
        % Potential function to compute attraction to the ball. In order to
        % avoid collisions between robots, the ball is less attractive than
        % the robots are repulsive.
        r = sqrt((Ball.x-Robot(i).x).^2+(Ball.y-Robot(i).y).^2);
        if ( r <= ra )
            dx = dx + C*(Ball.x-Robot(i).x)./r.^2*ra.^2/2;
            dy = dy + C*(Ball.y-Robot(i).y)./r.^2*ra.^2/2;
        end
        
        % Nominal directions
        dxn = cos(Robot(i).dir+dOmega(i));
        dyn = sin(Robot(i).dir+dOmega(i));
        
        %Direction in I & IV quadrant
        RobotStep(i).dir = atan((dyn+dy)./(dxn+dx));
        
        %Direction in II & III quadrant
        if( (dxn + dx) < 0 )
            RobotStep(i).dir = pi+RobotStep(i).dir;
        end
        
        % Motion equations for robots
        RobotStep(i).color = Robot(i).color;
        RobotStep(i).x = velocity(i) * cos(RobotStep(i).dir) + Robot(i).x;
        RobotStep(i).y = velocity(i) * sin(RobotStep(i).dir) + Robot(i).y;
        
        % Relative change of direction
        dAngle(i) = RobotStep(i).dir-Robot(i).dir;    
    end
    
    
%----------- Adding process noise  -----------%

    global Noise;
    d = randn(8,3);
    
    for i=1:8
        RobotStep(i).color = RobotStep(i).color;
        RobotStep(i).x = RobotStep(i).x + d(i,1) * Noise.Process.pos;
        RobotStep(i).y = RobotStep(i).y + d(i,2) * Noise.Process.pos;
        RobotStep(i).dir =  RobotStep(i).dir + d(i,3) * Noise.Process.dir;
    end
    
end


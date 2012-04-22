function [RobotStep d_omega velocity] = robot_step(Robot)
%DUMMY_STEP

    global RobotParam dt;
    
    d_omega = randn(8,1) * RobotParam.changeOfDir;
    velocity = ones(8,1) * 0.1 * dt; %[m/s]
    
    for i=1:8
        RobotStep(i).color = Robot(i).color;
        RobotStep(i).x = velocity(i) * cos(Robot(i).dir) + Robot(i).x;
        RobotStep(i).y = velocity(i) * sin(Robot(i).dir) + Robot(i).y;
        RobotStep(i).dir = d_omega(i) + Robot(i).dir;
    end
    
    % make sum noiz
    global Noise;
    d = randn(8,3);
    
    for i=1:8
        RobotStep(i).color = RobotStep(i).color;
        RobotStep(i).x = RobotStep(i).x + d(i,1) * Noise.process.pos;
        RobotStep(i).y = RobotStep(i).y + d(i,2) * Noise.process.pos;
        RobotStep(i).dir =  RobotStep(i).dir + d(i,3) * Noise.process.dir;
    end
    
    % COLLISION DETECTION
    
    for i = 1:8        
        % Robot collision
        for j = (i+1):8
            d = sqrt( (Robot(i).x-Robot(j).x)^2+(Robot(i).y-Robot(j).y)^2);
            if (d < 2*RobotParam.radius)
                d = Robot(i).dir;
                RobotStep(i).dir = Robot(j).dir;
                RobotStep(j).dir = d;
                
                % Step towards new direction
                RobotStep(i).x = velocity(i) * 2 * cos(RobotStep(i).dir) + RobotStep(i).x;
                RobotStep(i).y = velocity(i) * 2 * sin(RobotStep(i).dir) + RobotStep(i).y;
                RobotStep(j).x = velocity(i) * 2 * cos(RobotStep(j).dir) + RobotStep(j).x;
                RobotStep(j).y = velocity(i) * 2 * sin(RobotStep(j).dir) + RobotStep(j).y;
            end
        end
        
        % Boundaries collision
        if abs(RobotStep(i).x) > 3 - RobotParam.radius
            RobotStep(i).dir = pi - Robot(i).dir;
            RobotStep(i).x = velocity(i) * cos(RobotStep(i).dir) + Robot(i).x;
            RobotStep(i).y = velocity(i) * sin(RobotStep(i).dir) + Robot(i).y;
        end
        
        if abs(RobotStep(i).y) > 2 - RobotParam.radius
            RobotStep(i).dir = -Robot(i).dir;
            RobotStep(i).x = velocity(i) * cos(RobotStep(i).dir) + Robot(i).x;
            RobotStep(i).y = velocity(i) * sin(RobotStep(i).dir) + Robot(i).y;
        end
    end
    

end


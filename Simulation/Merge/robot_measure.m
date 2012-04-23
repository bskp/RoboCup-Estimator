function RobotMeasure = robot_measure(Robot)
%ROBOT_MEASURE Addition of measurement noise to the robots.
%
%   ROBOT_MEASURE = ROBOT_MEASURE(ROBOT) takes the parameter ROBOT and adds
%   measurement noise to the position and the direction of the robots. New
%   robots are created with the noisy measurements. Measurements for the
%   robots are only available from robots of the blue team and only if
%   other robots are in their field of vision.


    global Noise;
    global RobotParam;

    
%----------- Check available measurements -----------%    
    
    for i = 1:4         % Only blue robots recieve measurement signals
       for j = 1:8      % But all robots are measured if possible
            RobotAllMeasure(j).x(i) = NaN;
            RobotAllMeasure(j).y(i) = NaN;
            RobotAllMeasure(j).dir(i) = NaN;
       end
       
       if (position_is_valid(Robot(i)))
            for j = 1:8
                if (i == j)
                   RobotAllMeasure(j).x(i) = Robot(i).x + randn*Noise.measure.pos;
                   RobotAllMeasure(j).y(i) = Robot(i).y + randn*Noise.measure.pos;
                   RobotAllMeasure(j).dir(i) = Robot(i).dir + randn*Noise.measure.dir;
                   
                else
                    if (sqrt((Robot(i).x-Robot(j).x).^2 + (Robot(i).y-Robot(j).y).^2) <= RobotParam.sightDistance)
                        dirOtherRobot = atan((Robot(j).y-Robot(i).y)./(Robot(j).x-Robot(i).x));
                        
                        % Compute absolute angle in relation to the x-axis.
                        if (Robot(j).x < Robot(i).x)
                            dirOtherRobot = dirOtherRobot + pi;
                        end
                        
                        % Compute the relative angle of the robots position
                        % in relation to the looking direction of the blue
                        % robot.
                        posAngle = mod(abs(dirOtherRobot-Robot(i).dir),2*pi);
                        negAngle = posAngle-2*pi;
                        relAngle = min([abs(posAngle),abs(negAngle)]);
                        
                        if(relAngle < RobotParam.sightAngle) 
                            RobotAllMeasure(j).x(i) = Robot(j).x + randn*Noise.measure.pos;
                            RobotAllMeasure(j).y(i) = Robot(j).y + randn*Noise.measure.pos;
                            RobotAllMeasure(j).dir(i) = Robot(j).dir + randn*Noise.measure.dir;
                        end
                        
                    end
                    
                end
            end
       end
       
    end
    
    for i=1:8
        RobotAllMeasure(i).color = Robot(i).color;
    end
    
    RobotMeasure = measurement_fusion(RobotAllMeasure);
end


%------- Check whether robot is able to determine its own position -------%

function pos = position_is_valid(robot)

    global Field;
    global RobotParam;
    
    pos = false;
    
    %Characteristic points (Corners, half-wayline corners, goals and center)
    CharPoint(1) = struct('x', Field.width./2, 'y', Field.height./2);
    CharPoint(2) = struct('x', -Field.width./2, 'y', Field.height./2);
    CharPoint(3) = struct('x', Field.width./2, 'y', -Field.height./2);
    CharPoint(4) = struct('x', -Field.width./2, 'y', -Field.height./2);
    CharPoint(5) = struct('x', 0, 'y', Field.height./2);
    CharPoint(6) = struct('x', 0, 'y', -Field.height./2);
    CharPoint(7) = struct('x', Field.width./2, 'y', 0);
    CharPoint(8) = struct('x', -Field.width./2, 'y', 0);     
    CharPoint(9) = struct('x', 0, 'y', 0);
    
    %Is a characetistic point in Sight of View ?
    for i = 1:length(CharPoint)
        if (sqrt((CharPoint(i).x-robot.x).^2 + (CharPoint(i).y-robot.y).^2 ) <= RobotParam.sightDistance)
            dirCharPoint = atan((CharPoint(i).y-robot.y)./(CharPoint(i).x-robot.x));
            
            % Compute absolute angle in relation to the x-axis.
            if (CharPoint(i).x < robot.x)
                dirCharPoint = dirCharPoint + pi;
            end
            
            % Compute the relative angle of the robots position
            % in relation to the looking direction of the blue
            % robot.
            posAngle = mod(abs(dirCharPoint-robot.dir),2*pi);
            negAngle = posAngle-2*pi;
            relAngle = min([abs(posAngle),abs(negAngle)]);
            
            if(relAngle < RobotParam.sightAngle)
                pos = true;
                return;
            end
        end
    end
        
end


%----------- Fusion of multiple measurements of one robot -----------%

function RobotMeasure = measurement_fusion(RobotAllMeasure)

    for i = 1:8
        RobotMeasure(i).color = RobotAllMeasure.color;
        
        k = 0;      % Number of measurements
        x = 0;
        y = 0;
        dir = 0;
        for j = 1:4
            if (~isnan(RobotAllMeasure(i).x(j)))     % Check for measurement
                x = x + RobotAllMeasure(i).x(j);
                y = y + RobotAllMeasure(i).y(j);
                dir = dir + RobotAllMeasure(i).dir(j);
                k = k + 1;
            end
        end
        
        % Compute the mean of all measurements
        RobotMeasure(i).x = x./k;
        RobotMeasure(i).y = y./k;
        RobotMeasure(i).dir = dir./k;
    end
    
end
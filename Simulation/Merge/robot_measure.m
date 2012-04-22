function RobotMeasure = robot_measure(Robot)
%ROBOT_MEASURE

    global Noise;
    global RobotParam;
    
    for i = 1:4
       for j = 1:8
            RobotAllMeasure(j).x(i) = NaN;
            RobotAllMeasure(j).y(i) = NaN;
            RobotAllMeasure(j).dir(i) = NaN;
       end
       
       if position_is_valid(Robot(i))
            for j = 1:8
                if i == j
                   RobotAllMeasure(j).x(i) = Robot(i).x + rand*Noise.measure.pos;
                   RobotAllMeasure(j).y(i) = Robot(i).y + rand*Noise.measure.pos;
                   RobotAllMeasure(j).dir(i) = Robot(i).dir + rand*Noise.measure.dir;
                else
                    if sqrt((Robot(i).x-Robot(j).x).^2 + (Robot(i).y-Robot(j).y).^2 ) < RobotParam.sightDistance
                        dirOtherRobot = atan((Robot(i).y-Robot(j).y)./(Robot(i).x-Robot(j).x));
                        
                        if dirOtherRobot > Robot(i).dir - RobotParam.sightAngle && dirOtherRobot > Robot(i).dir + RobotParam.sightAngle
                            RobotAllMeasure(j).x(i) = Robot(i).x + rand*Noise.measure.pos;
                            RobotAllMeasure(j).y(i) = Robot(i).y + rand*Noise.measure.pos;
                            RobotAllMeasure(j).dir(i) = Robot(i).dir + rand*Noise.measure.dir;
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

function pos = position_is_valid(robot)
%POSITION_IS_VALID

    global Field;
    global RobotParam;
    
    pos = false;
    
    %Characteristic points
    CharPoint(1) = struct('x', Field.width./2, 'y', Field.height./2);
    CharPoint(2) = struct('x', -Field.width./2, 'y', Field.height./2);
    CharPoint(3) = struct('x', Field.width./2, 'y', -Field.height./2);
    CharPoint(4) = struct('x', -Field.width./2, 'y', -Field.height./2);
    CharPiont(5) = struct('x', 0, 'y', Field.height./2);
    CharPiont(6) = struct('x', 0, 'y', -Field.height./2);
    CharPoint(7) = struct('x', 0, 'y', 0);
    
    %Is a characetistic point in Sight of View ?
    for i = 1:length(CharPoint)
        if sqrt((CharPoint(i).x-robot.x).^2 + (CharPoint(i).y-robot.y).^2 ) < RobotParam.sightDistance
            dirCharPoint = atan((CharPoint(i).y-robot.y)./(CharPoint(i).x-robot.x));
            if dirCharPoint > robot.dir - RobotParam.sightAngle && dirCharPoint > robot.dir + RobotParam.sightAngle
                pos = true;
            end
        end
    end
        
end

function RobotMeasure = measurement_fusion(RobotAllMeasure)
%MEASUREMENT_FUSION

    for i = 1:8
        RobotMeasure(i).color = RobotAllMeasure.color;
        
        k = 0;
        x = 0;
        y = 0;
        dir = 0;
        for j = 1:4
            if ~isnan(RobotAllMeasure(i).x(j))
                x = x + RobotAllMeasure(i).x(j);
                y = y + RobotAllMeasure(i).y(j);
                dir = dir + RobotAllMeasure(i).dir(j);
                k = k + 1;
            end
        end
        RobotMeasure(i).x = x./k;
        RobotMeasure(i).y = y./k;
        RobotMeasure(i).dir = dir./k;
    end
    
end
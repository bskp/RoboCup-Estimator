function RobotMeasure = robot_measure(Robot)
%DUMMY_PROCESSNOISE

    global Noise;
    d = randn(8,3);
    p = rand(8,3);
    
    for i=1:8
        RobotMeasure(i).color = Robot(i).color;
        if p(i,1) > Noise.measure.prob
            RobotMeasure(i).x = Robot(i).x + d(i,1) * Noise.measure.pos;
        else
            RobotMeasure(i).x = NaN;
        end
        
        if p(i,2) > Noise.measure.prob
            RobotMeasure(i).y = Robot(i).y + d(i,2) * Noise.measure.pos;
        else
            RobotMeasure(i).y = NaN;
        end
        
        if p(i,3) > Noise.measure.prob
            RobotMeasure(i).dir = Robot(i).dir + d(i,3) * Noise.measure.dir;
        else
            RobotMeasure(i).dir = NaN;
        end
    end
    
end

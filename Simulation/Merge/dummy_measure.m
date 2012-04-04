function RobotMeasure = dummy_measure(Robot)
%DUMMY_PROCESSNOISE

    global Noise;
    d = randn(8,2);
    
    for i=1:8
        RobotMeasure(i).color = Robot(i).color;
        RobotMeasure(i).x = Robot(i).x + d(i,1) * Noise.measure.pos;
        RobotMeasure(i).y = Robot(i).y + d(i,2) * Noise.measure.pos;
        % Unmeasured state:
        RobotMeasure(i).dir = NaN;
    end
    
end


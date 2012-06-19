function RobotMeasure = robot_optimistic_measure(Robot)
%ROBOT_SIGHT_OF_VIEW_MEASURE Addition of measurement noise to the robots.
%
%   ROBOTMEASURE = ROBOT_OPTIMISTIC_MEASURE(ROBOT) Measure always!
%   With noise.


%----------- Create normally distributed noise  -----------%

    global Noise;
    d = randn(8,3); % Noise values
    
%----------- Adding noise to the parameters -----------%
    
    for i=1:8
        RobotMeasure(i).color = Robot(i).color;
            
        RobotMeasure(i).x = Robot(i).x + d(i,1)*Noise.Measure.pos;
        RobotMeasure(i).y = Robot(i).y + d(i,2)*Noise.Measure.pos;
        RobotMeasure(i).dir = Robot(i).dir + d(i,3)*Noise.Measure.dir;
        RobotMeasure(i).sigma = 1;

    end
    
end
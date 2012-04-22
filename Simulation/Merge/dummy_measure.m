function RobotMeasure = dummy_measure(Robot)
%DUMMY_MEASURE Addition of measurement noise to the robots.
%
%   ROBOTMEASURE = DUMMY_MEASURE(ROBOT) takes the parameter ROBOT and adds
%   measurement noise to the position and the direction of the robots. New
%   robots are created with the noisy measurements. Furthermore, with a
%   certain probability, measurement of some parameters are dropped for
%   each robot individually.


%----------- Create normally distributed noise  -----------%

    global Noise;
    d = randn(8,3);
    p = rand(8,3);
    
    
%----------- Adding noise to the parameters -----------%
    
    for i=1:8
        RobotMeasure(i).color = Robot(i).color;
        
        
        if p(i,1) > Noise.measure.prob
            RobotMeasure(i).x = Robot(i).x + d(i,1) * Noise.measure.pos;
        else
            RobotMeasure(i).x = NaN;    % Measurement drop
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


function RobotMeasure = robot_random_measure(Robot)
%DUMMY_MEASURE Addition of measurement noise to the robots.
%
%   ROBOTMEASURE = DUMMY_MEASURE(ROBOT) takes the parameter ROBOT and adds
%   measurement noise to the position and the direction of the robots. New
%   robots are created with the noisy measurements. Furthermore, with a
%   certain probability, measurement of some parameters are dropped for
%   each robot individually.


%----------- Create normally distributed noise  -----------%

    global Noise;
    Noise.Measure.prob = 0.2; % Probability for Measurementdrop
    d = randn(8,3); % Noise values
    p = rand(8,1);  % Measurement-probability-deciders
    
    
%----------- Adding noise to the parameters -----------%
    
    for i=1:8
        RobotMeasure(i).color = Robot(i).color;
        
        
        if ( p(i) > Noise.Measure.prob )
            
            RobotMeasure(i).x = Robot(i).x + d(i,1)*Noise.Measure.pos;
            RobotMeasure(i).y = Robot(i).y + d(i,2)*Noise.Measure.pos;
            RobotMeasure(i).dir = Robot(i).dir + d(i,3)*Noise.Measure.dir;
            RobotMeasure(i).sigma = 1;
            
        else
            
            RobotMeasure(i).x = NaN;    % Measurement drop
            RobotMeasure(i).y = NaN;
            RobotMeasure(i).dir = NaN;
            RobotMeasure(i).sigma = NaN;
            
        end
    end
    
end
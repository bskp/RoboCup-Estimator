function BallMeasure = ball_sight_of_view_measure(Robot, Ball)
%BALL_MEASURE Addition of measurement noise to the ball.
%
%   BALLMEASURE = BALL_SIGHT_OF_VIEW_MEASURE(ROBOT,BALL) determines whether
%   BALL is measurable and adds measurement noise to it. With the struct
%   ROBOT the function checks, whether there is at least one blue robot
%   which gets visual information about the ball. If no robot sees the
%   ball, the measurement is dropped. If there is more than one
%   measurement, measurement fusion is applied.

    global Noise; % Let's just assume the same noise values as for robots
    global RobotParam;
    
    BallMeasure.x = NaN;
    BallMeasure.y = NaN;
    BallMeasure.dir = NaN;
    BallMeasure.velocity = NaN;
    
    numMeasurements = 0;   % Number of available measurements
    atLeastOne = false;   % Flag to determine whether at least one robot
                            % gets a measurement.
    posX = zeros(1,4)*NaN;
    posY = zeros(1,4)*NaN;
    dir = zeros(1,4)*NaN;
    velocity = zeros(1,4)*NaN;
    sigma = zeros(1,4)*NaN;

    
%----------- Check available measurements -----------%

for i=1:4           % Only the first 4 robots (the blue ones) get signals.
    if (position_is_valid(Robot(i)))
    end

    if (sqrt((Robot(i).x-Ball.x).^2 + (Robot(i).y-Ball.y).^2) <= ...
            RobotParam.sightDistance)
        dirBall = atan((Ball.y-Robot(i).y)./(Ball.x-Robot(i).x));

        % Compute absolute angle in relation to the x-axis.
        if (Ball.x < Robot(i).x)
            dirBall = dirBall + pi;
        end
                        
         % Compute the relative angle of the ball in relation to the
         % angle of the looking direction of a blue robot.
         posAngle = mod(abs(dirBall-Robot(i).dir),2*pi);
         negAngle = posAngle-2*pi;
         relAngle = min([abs(posAngle),abs(negAngle)]);
             
         % If measurement is available, add it and compute the covariance
         % of the measurement, depending on the circumstances under which
         % the measurement was gained.
         if(relAngle < RobotParam.sightAngle) 
            atLeastOne = true;
            numMeasurements = numMeasurements + 1;
            
            if (position_is_valid(Robot(i)))
                posX(i) = Ball.x + randn*Noise.Measure.pos*Noise.Measure.sigma2;
                posY(i) = Ball.y + randn*Noise.Measure.pos*Noise.Measure.sigma2;
                dir(i) = Ball.dir + randn*Noise.Measure.dir*Noise.Measure.sigma2;
                %velocity(i) = velocity(i) + Ball.velocity + randn*Noise.Measure.pos*Noise.Measure.sigma2;
                sigma(i) = Noise.Measure.pos*Noise.Measure.sigma2;
            else
                posX(i) = Ball.x + randn*Noise.Measure.pos*Noise.Measure.sigma3;
                posY(i) = Ball.y + randn*Noise.Measure.pos*Noise.Measure.sigma3;
                dir(i) = Ball.dir + randn*Noise.Measure.dir*Noise.Measure.sigma3;
                %velocity(i) = velocity(i) + Ball.velocity + randn*Noise.Measure.pos*Noise.Measure.sigma3;
                sigma(i) = Noise.Measure.pos*Noise.Measure.sigma3;
            end
            
         end
     end     
end



% Take the weighted mean value of all measurements
    if(atLeastOne)
        k=0;
        BallMeasure.x = 0;
        BallMeasure.y = 0;
        BallMeasure.dir = 0;
        BallMeasure.velocity = 0;
        for i=1:4
            if(~isnan(posX(i)))
                BallMeasure.x = BallMeasure.x + posX(i)./(sigma(i).^2);
                BallMeasure.y = BallMeasure.y + posY(i)./(sigma(i).^2);
                BallMeasure.dir = BallMeasure.dir + dir(i)./(sigma(i).^2);
                BallMeasure.velocity = BallMeasure.velocity + ...
                    velocity(i)./(sigma(i).^2);
                k = k + 1./(sigma(i).^2);
            end
        end
        BallMeasure.x = BallMeasure.x./k;
        BallMeasure.y = BallMeasure.y./k;
        BallMeasure.dir = BallMeasure.dir./k;
        BallMeasure.velocity = BallMeasure.velocity./k;
    end

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
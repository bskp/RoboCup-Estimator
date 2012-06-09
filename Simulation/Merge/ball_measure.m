function Ball_m = ball_measure(Robot, Ball)
%BALL_MEASURE Addition of measurement noise to the ball.
%
%   BALL_M = BALL_MEASURE(ROBOT,BALL) determines whether BALL is
%   measurable and adds process noise to it. With the struct ROBOT the
%   function checks, whether there is at least one robot which gets visual
%   information about the ball. If no robot sees the ball, the measurement
%   is dropped.

    global Noise; % Let's just assume the same noise values as for robots
    global RobotParam;
    
    Ball_m.x = NaN;
    Ball_m.y = NaN;
    Ball_m.dir = NaN;
    Ball_m.velocity = NaN;
    
    num_measurements = 0;   % Number of available measurements
    at_least_one = false;   % Flag to determine whether at least one robot
                            % gets a measurement.
    pos_x = zeros(1,4)*NaN;
    pos_y = zeros(1,4)*NaN;
    dir = zeros(1,4)*NaN;
    velocity = zeros(1,4)*NaN;
    sigma = zeros(1,4)*NaN;

    
%----------- Check available measurements -----------%

for i=1:4           % Only the first 4 robots (the blue ones) get signals.
    if (position_is_valid(Robot(i)))
    end

    if (sqrt((Robot(i).x-Ball.x).^2 + (Robot(i).y-Ball.y).^2) <= RobotParam.sightDistance)
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
            at_least_one = true;
            num_measurements = num_measurements + 1;
            
            if (position_is_valid(Robot(i)))
                pos_x(i) = Ball.x + randn*Noise.measure.pos*Noise.measure.sigma2;
                pos_y(i) = Ball.y + randn*Noise.measure.pos*Noise.measure.sigma2;
                dir(i) = Ball.dir + randn*Noise.measure.dir*Noise.measure.sigma2;
                %velocity(i) = velocity(i) + Ball.velocity + randn*Noise.measure.pos*Noise.measure.sigma2;
                sigma(i) = Noise.measure.pos*Noise.measure.sigma2;
            else
                pos_x(i) = Ball.x + randn*Noise.measure.pos*Noise.measure.sigma3;
                pos_y(i) = Ball.y + randn*Noise.measure.pos*Noise.measure.sigma3;
                dir(i) = Ball.dir + randn*Noise.measure.dir*Noise.measure.sigma3;
                %velocity(i) = velocity(i) + Ball.velocity + randn*Noise.measure.pos*Noise.measure.sigma3;
                sigma(i) = Noise.measure.pos*Noise.measure.sigma3;
            end
            
         end
     end     
end



% Take the weighted mean value of all measurements
    if(at_least_one)
        k=0;
        Ball_m.x = 0;
        Ball_m.y = 0;
        Ball_m.dir = 0;
        Ball_m.velocity = 0;
        for i=1:4
            if(~isnan(pos_x(i)))
                Ball_m.x = Ball_m.x + pos_x(i)./sigma(i);
                Ball_m.y = Ball_m.y + pos_y(i)./sigma(i);
                Ball_m.dir = Ball_m.dir + dir(i)./sigma(i);
                Ball_m.velocity = Ball_m.velocity + velocity(i)./sigma(i);
                k = k + 1./sigma(i);
            end
        end
        Ball_m.x = Ball_m.x./k;
        Ball_m.y = Ball_m.y./k;
        Ball_m.dir = Ball_m.dir./k;
        Ball_m.velocity = Ball_m.velocity./k;
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
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
    sum_x = 0;
    sum_y = 0;
    sum_d = 0;
    sum_v = 0;

    
%----------- Check available measurements -----------%

for i=1:4           % Only the first 4 robots (the blue ones) get signals.
    if (position_is_valid(Robot(i)))

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
             
             % If measurement is available, add it
             if(relAngle < RobotParam.sightAngle) 
                at_least_one = true;
                num_measurements = num_measurements + 1;
                sum_x = sum_x + Ball.x + randn*Noise.measure.pos;
                sum_y = sum_y + Ball.y + randn*Noise.measure.pos;
                sum_d = sum_d + Ball.dir + randn*Noise.measure.dir;
                %sum_v = sum_v + Ball.velocity + randn*Noise.measure.pos;
             end
         end
            
    end
end

% Take the mean value of all measurements
if(at_least_one)
    Ball_m.x = sum_x/num_measurements;
    Ball_m.y = sum_y/num_measurements;
    Ball_m.dir = sum_d/num_measurements;
    Ball_m.velocity = sum_v/num_measurements;
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
function [robot_step P_step] = ext_kalman_filter(robot,P)
%EXT_KALMAN_FILTER
    global Noise;
    
%init
    W = [Noise.process.pos*eye(2), [0;0]; [0 0 Noise.process.dir] ];
    Q = eye(2)*Noise.measure.pos;
    H = ;
    V = ;
    W = ;

% Algorithm taken from kalman_intro.pdf
% Time update (predict)
    for i=1:8
       A = [1 0 -RobotParam.velocity*sin(robot.dir);
            0 1 RobotParam.velocity*cos(robot.dir);
            0 0 1];

       P_apriori = 
       x_apriori = 

% Measurement update (correct)
       K =  ;
       robot_step(i).x =
       robot_step(i).y =
       robot_step(i).dir =
       P_step(i) = 
    end
end


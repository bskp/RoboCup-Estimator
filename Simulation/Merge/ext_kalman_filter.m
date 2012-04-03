function [RobotStep PStep] = ext_kalman_filter(RobotFilt,RobotMeas,P)
%EXT_KALMAN_FILTER
    global Noise;
    global RobotParam;
    
%init
    R = [Noise.process.pos*eye(2), [0;0]; [0 0 Noise.process.dir] ];
    Q = [Noise.measure.pos*eye(2), [0;0]; [0 0 Noise.measure.dir] ];
    H = eye(3);
    V = eye(3);
    W = eye(3);

% Algorithm taken from kalman_intro.pdf
% Time update (predict)
    for i=1:8
       A = [1 0 -RobotParam.velocity*sin(RobotFilt(i).dir);
            0 1 RobotParam.velocity*cos(RobotFilt(i).dir);
            0 0 1];

       P_apriori{i} = A*P{i}*A'+ W*Q*W';
       x = zeros(3,1);
       x(1) = RobotParam.velocity * cos(RobotFilt(i).dir) + RobotFilt(i).x;
       x(2) = RobotParam.velocity * sin(RobotFilt(i).dir) + RobotFilt(i).y;
       x(3) = RobotFilt(i).dir;

% Measurement update (correct)
       K = (P_apriori{i}*H')/(H*P_apriori{i}*H' + V*R*V');
       x_meas = zeros(3,1);
       x_meas(1) = RobotMeas(i).x;
       x_meas(2) = RobotMeas(i).y;
       x_meas(3) = RobotMeas(i).dir;
       x = x + K*(x_meas - H*x);
       RobotStep(i).color = RobotFilt(i).color;
       RobotStep(i).x = x(1);
       RobotStep(i).y = x(2);
       RobotStep(i).dir = x(3);
       PStep{i} = (eye(3) - K*H)*P_apriori{i};
    end
end


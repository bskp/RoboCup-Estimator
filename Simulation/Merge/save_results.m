    
RobotStep(s,:,:) = Robot;
RobotStep_e(s,:,:) = Robot_e;
BallStep(s) = Ball;
BallStep_e(s) = Ball_e;
    
PStep(s,:,:,:) = P;
    
if (s == steps)
    save('error', 'steps');
    save('error', 'RobotStep', '-append');
    save('error', 'RobotStep_e', '-append');
    save('error', 'BallStep', '-append');
    save('error', 'BallStep_e', '-append');
    
    save('error', 'PStep', '-append');
end


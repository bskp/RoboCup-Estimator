% Save the structs of the robots and the ball for every step

    sRobot(s,:,:) = Robot;
    sRobotEstimate(s,:,:) = RobotEstimate;
    sBall(s) = Ball;
    sBallEstimate(s) = BallEstimate;
    
 % Save the norm of the P matrix of the robots for every step

    for i=1:8
        sPnorm(i,s) = norm(P(:,:,i));
    end
    
% Save the norm of the K matrix of the robots for every step

    for i=1:8
        sKnorm(i,s) = Knorm(i);
    end
    
    
% Save the norm of the K matrix of the ball for every step

    for i=1:8
        sKBnorm(s) = KBnorm;
    end
    
% Save the norm of the P matrix of the ball for every step

    sPballNorm(s) = norm(Pball);
    
% Save the all datas into a .mat file
if (s == steps)
    save('plot', 'steps');
    save('plot', 'sRobot', '-append');
    save('plot', 'sRobotEstimate', '-append');
    save('plot', 'sBall', '-append');
    save('plot', 'sBallEstimate', '-append');
    
    save('plot', 'sPnorm', '-append');
    save('plot', 'sPballNorm', '-append');
    save('plot', 'sKnorm', '-append');
    save('plot', 'sKBnorm', '-append');
end


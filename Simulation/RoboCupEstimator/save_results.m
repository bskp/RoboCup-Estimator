% Save the structs of the robots and the ball for every step

    sRobot(s,:,:) = Robot;
    sRobot_e(s,:,:) = Robot_e;
    sBall(s) = Ball;
    sBall_e(s) = Ball_e;
    
% Save the norm of the P matrix of the robots for every step

    for i=1:8
        sP_norm(i,s) = norm(P(:,:,i));
    end
    
% Save the norm of the P matrix of the ball for every step

    sP_ball_norm(s) = norm(P_ball);
    
% Save the all datas into a .mat file
if (s == steps)
    save('plot', 'steps');
    save('plot', 'sRobot', '-append');
    save('plot', 'sRobot_e', '-append');
    save('plot', 'sBall', '-append');
    save('plot', 'sBall_e', '-append');
    
    save('plot', 'sP_norm', '-append');
    save('plot', 'sP_ball_norm', '-append');
end


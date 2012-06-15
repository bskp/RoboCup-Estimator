function report(steps, RobotStep, RobotStep_e, BallStep, BallStep_e)
%REPORT Creates a mat-File with data from robots and ball
%
%   REPORT(STEPS,ROBOTSTEP,ROBOTSTEP_E,BALLSTEP,BALLSTEP_E) takes the ideal
%   and the estimated values for the robots and the ball and saves them in
%   the file error.mat.

    
%     RobotStep{s} = Robot;
%     RobotStep_e{s} = Robot_e;

      save('error', 'steps');
      save('error', 'RobotStep', '-append');
      save('error', 'RobotStep_e', '-append');
      save('error', 'BallStep', '-append');
      save('error', 'BallStep_e', '-append');


%     currentPath = pwd;
%     fid = fopen(currentPath, 'w');
%     fprintf(fid,'%f\n',s);
%     fclose(fid);

end
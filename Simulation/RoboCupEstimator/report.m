function report(steps, RobotStep, RobotStepEstimate, BallStep, BallStepEstimate)
%REPORT Creates a mat-File with data from robots and ball
%
%   REPORT(STEPS,ROBOTSTEP,ROBOTSTEPESTIMATE,BALLSTEP,BALLSTEPESTIMATE)
%   takes the ideal and the estimated values for the robots and the ball
%   and saves them in the file error.mat.

    
%     RobotStep{s} = Robot;
%     RobotStep_e{s} = Robot_e;

      save('error', 'steps');
      save('error', 'RobotStep', '-append');
      save('error', 'RobotStepEstimate', '-append');
      save('error', 'BallStep', '-append');
      save('error', 'BallStepEstimate', '-append');


%     currentPath = pwd;
%     fid = fopen(currentPath, 'w');
%     fprintf(fid,'%f\n',s);
%     fclose(fid);

end
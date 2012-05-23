function report(steps, RobotStep, RobotStep_e, BallStep, BallStep_e)
%REPORT Summary of this function goes here
%   Detailed explanation goes here


% Create a mat-File with data from robots and ball

    
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
function report(s, steps, Robot, Robot_e)
%REPORT Summary of this function goes here
%   Detailed explanation goes here

% global RobotStep;
% global RobotStep_e;
% RobotStep = zeros(steps, 8, 4);
% RobotStep_e = zeros(steps, 8, 4);
% RobotStep(s,:,:) = Robot;
% RobotStep_e(s,:,:) = Robot_e;

% Create a mat-File with data from robots and ball

    RobotStep(s,:,:) = Robot
    RobotStep_e(s,:,:) = Robot_e
    if (s == steps)
        save('error', 'steps');
        save('error', 'RobotStep', '-append');
        save('error', 'RobotStep_e', '-append');
    end
    
    
%     if (s==1)
%         save('error', 'Robot');
%     else
%         save('error', 'Robot', '-append');
%     end

%     currentPath = pwd;
%     fid = fopen(currentPath, 'w');
%     fprintf(fid,'%f\n',s);
%     fclose(fid);

end
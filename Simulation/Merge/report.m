function report(s, steps, Robot, Robot_e)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global RobotStep;
global RobotStep_e;
%RobotStep = zeros(steps, 8, 4);
%RobotStep_e = zeros(steps, 8, 4);

% Create a txt-File with data from robots and the estimation
%     save('error', 'Robot');
%     save('error', 'Robot_e', '-append');
    save('error', 'Robot', 'Robot_e');
%     if (s < steps)
%         RobotStep(s,:,:) = Robot;
%         RobotStep_e(s,:,:) = Robot_e;
%     else
%         save('steps')
%         save('error', 'RobotStep');
%         save('error', 'RobotStep_e');
%     end
%     if (s==1)
%         save('error', 'Robot');
%     else
%         save('error', 'Robot', '-append');
%     end

%     currentPath = pwd;
%     fid = fopen(currentPath, 'w');
%     fprintf(fid,'%f\n',s);
%     fclose(fid);




% % Plot team blue (our team)
% 
%     if (s <= 4)
%         figure(2);
%         e_x = abs(Robot(s).x-Robot_e(s).x);
%         e_y = abs(Robot(s).y-Robot_e(s).y);
%         e_dir = abs(Robot(s).dir-Robot_e(s).dir);
%         if (s == 1)
%             subplot(4,4,1);
%             title('Robot 1 - x error');
%             plot(s, e_x, 'r');
%             subplot(4,4,2);
%             title('Robot 1 - y error');
%             plot(s, e_y, 'r');
%             subplot(4,4,3);
%             title('Robot 1 - phi error');
%             plot(s, e_dir, 'r');
%         end
%     	if (s == 2)
%             subplot(4,4,1);
%             title('Robot 2 - x error');
%             plot(s, e_x, 'g');
%             subplot(4,4,2);
%             title('Robot 2 - y error');
%             plot(s, e_y, 'g');
%             subplot(4,4,3);
%             title('Robot 2 - phi error');
%             plot(s, e_dir, 'g');
%         end
%         if (s == 3)
%             subplot(4,4,1);
%             plot(s, e_x, 'b');
%             subplot(4,4,2);
%             plot(s, e_y, 'b');
%             subplot(4,4,3);
%             plot(s, e_dir, 'b');
%         end
%         if (s == 4)
%             subplot(4,4,1);
%             plot(s, e_x, 'k');
%             subplot(4,4,2);
%             plot(s, e_y, 'k');
%             subplot(4,4,3);
%             plot(s, e_dir, 'k');
%         end
%     end
% 
% % Plot team red (enemies)
% 
%     if (s > 4)
%         figure(3);
%         title('Robot 1 - error');
%         e_x = abs(Robot(s).x-Robot_e(s).x);
%         e_y = abs(Robot(s).y-Robot_e(s).y);
%         e_dir = abs(Robot(s).dir-Robot_e(s).dir);
%         if (s == 1)
%             subplot(4,4,1);
%             plot(s, e_x, 'r');
%             subplot(4,4,2);
%             plot(s, e_y, 'r');
%             subplot(4,4,3);
%             plot(s, e_dir, 'r');
%         end
%     	if (s == 2)
%             subplot(4,4,1);
%             plot(s, e_x, 'g');
%             subplot(4,4,2);
%             plot(s, e_y, 'g');
%             subplot(4,4,3);
%             plot(s, e_dir, 'g');
%         end
%         if (s == 3)
%             subplot(4,4,1);
%             plot(s, e_x, 'b');
%             subplot(4,4,2);
%             plot(s, e_y, 'b');
%             subplot(4,4,3);
%             plot(s, e_dir, 'b');
%         end
%         if (s == 4)
%             subplot(4,4,1);
%             plot(s, e_x, 'k');
%             subplot(4,4,2);
%             plot(s, e_y, 'k');
%             subplot(4,4,3);
%             plot(s, e_dir, 'k');
%         end
%     end
% 
% % Plot ball

end
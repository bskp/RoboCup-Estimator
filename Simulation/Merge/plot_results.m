% Create a txt-File with data from robots and the estimation

load('error', 'steps')
load('error', 'RobotStep');
load('error', 'RobotStep_e');
% Robot = zeros(8);
% Robot_e = zeros(8);

for s=1:steps
    for i=1:8
        Robot = RobotStep(s, 1, i);
        Robot_e = RobotStep_e(s, 1, i);

        % Plot team blue (our team)
        if (i <= 4)
            figure(2);
%             e_x = abs(Robot(i).x-Robot_e(i).x);
%             e_y = abs(Robot(i).y-Robot_e(i).y);
%             e_dir = abs(Robot(i).dir-Robot_e(i).dir);
            e_x = abs(Robot.x-Robot_e.x);
            e_y = abs(Robot.y-Robot_e.y);
            e_dir = abs(Robot.dir-Robot_e.dir);
            length(e_x)
            length(s)
            if (i == 1)
                subplot(4,4,1);
                title('Robot 1 - x error');
                plot(steps, e_x, 'r');
                subplot(4,4,2);
                title('Robot 1 - y error');
                plot(steps, e_y, 'r');
                subplot(4,4,3);
                title('Robot 1 - phi error');
                plot(s, e_dir, 'r');
            end
            if (s == 2)
                subplot(4,4,1);
                title('Robot 2 - x error');
                plot(s, e_x, 'g');
                subplot(4,4,2);
                title('Robot 2 - y error');
                plot(s, e_y, 'g');
                subplot(4,4,3);
                title('Robot 2 - phi error');
                plot(s, e_dir, 'g');
            end
            if (s == 3)
                subplot(4,4,1);
                plot(s, e_x, 'b');
                subplot(4,4,2);
                plot(s, e_y, 'b');
                subplot(4,4,3);
                plot(s, e_dir, 'b');
            end
            if (s == 4)
                subplot(4,4,1);
                plot(s, e_x, 'k');
                subplot(4,4,2);
                plot(s, e_y, 'k');
                subplot(4,4,3);
                plot(s, e_dir, 'k');
            end
        end

        % Plot team red (enemies)

        if (i > 4)
            figure(3);
            title('Robot 1 - error');
            e_x = abs(Robot(i).x-Robot_e(i).x);
            e_y = abs(Robot(i).y-Robot_e(i).y);
            e_dir = abs(Robot(i).dir-Robot_e(i).dir);
            if (s == 1)
                subplot(4,4,1);
                plot(s, e_x, 'r');
                subplot(4,4,2);
                plot(s, e_y, 'r');
                subplot(4,4,3);
                plot(s, e_dir, 'r');
            end
            if (s == 2)
                subplot(4,4,1);
                plot(s, e_x, 'g');
                subplot(4,4,2);
                plot(s, e_y, 'g');
                subplot(4,4,3);
                plot(s, e_dir, 'g');
            end
            if (s == 3)
                subplot(4,4,1);
                plot(s, e_x, 'b');
                subplot(4,4,2);
                plot(s, e_y, 'b');
                subplot(4,4,3);
                plot(s, e_dir, 'b');
            end
            if (s == 4)
                subplot(4,4,1);
                plot(s, e_x, 'k');
                subplot(4,4,2);
                plot(s, e_y, 'k');
                subplot(4,4,3);
                plot(s, e_dir, 'k');
            end
        end

        % Plot ball
        
    end
    
end


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
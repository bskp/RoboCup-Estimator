% Create a txt-File with data from robots and the estimation

load('error', 'steps');
load('error', 'RobotStep');
load('error', 'RobotStep_e');


% Calculation of error for every Robot and the ball
for s=1:steps
    for i=1:8
        Robot = RobotStep(s,1,i);
        Robot_e = RobotStep_e(s,1,i);
         
        e_x(i,s) = abs(Robot.x-Robot_e.x);
        e_y(i,s) = abs(Robot.y-Robot_e.y);
        e_dir(i,s) = abs(Robot.dir-Robot_e.dir);
    end  
end

% pcolor = cell(3,1);
% pcolor{1,1}='red';
% pcolor{2,1}='blue';
% pcolor{3,1}='green';


pcolor(1) = 'r';
pcolor(2) = 'g';
pcolor(3) = 'b';
pcolor(4) = 'k';


x = linspace(1, steps, steps);
figure(2);
hold on
subplot(2,2,1);
plot(x, e_x(1:4,:), pcolor(1));
subplot(2,2,2);
plot(x, e_y(1:4,:), pcolor(2));
        
% for i=1:8
%     for j=1:3
%         
%         if (i <= 4)
%             
%             subplot(2,2,j);
%             title('x error');
%             plot(x, e_x(i,:), pcolor(i));
%             subplot(2,2,j);
%             title('y error');
%             plot(x, e_y(i,:), pcolor(i));
%             subplot(2,2,j);
%             title('phi error');
%             plot(x, e_dir(i,:), pcolor(i));
%         else
%         end
%     end
% end
    
    
%     
%     
%     % Plot team blue (our team)
%     if (i <= 4)
%         figure(2);
%         title('Team blue - error');
%         if (i == 1)
%             subplot(4,4,1);
%             title('x error');
%             plot(steps, e_x(i,:), 'r');
%             subplot(4,4,2);
%             title('y error');
%             plot(steps, e_y(i,:), 'r');
%             subplot(4,4,3);
%             title('phi error');
%             plot(steps, e_dir(i,:), 'r');
%         end
%         if (s == 2)
%             subplot(4,4,1);
%             plot(steps, e_x(i,:), 'g');
%             subplot(4,4,2);
%             plot(steps, e_y(i,:), 'g');
%             subplot(4,4,3);
%             plot(steps, e_dir(i,:), 'g');
%         end
%         if (s == 3)
%             subplot(4,4,1);
%             plot(steps, e_x(i,:), 'b');
%             subplot(4,4,2);
%             plot(steps, e_y(i,:), 'b');
%             subplot(4,4,3);
%             plot(steps, e_dir(i,:), 'b');
%         end
%         if (s == 4)
%             subplot(4,4,1);
%             plot(steps, e_x(i,:), 'k');
%             subplot(4,4,2);
%             plot(steps, e_y(i,:), 'k');
%             subplot(4,4,3);
%             plot(steps, e_dir(i,:), 'k');
%         end
%     end
% 
%     % Plot team red (enemies)
% 
%     if (i > 4)
%         figure(3);
%         title('Team red - error');
%         if (i == 1)
%             subplot(4,4,1);
%             title('Robot 1 - x error');
%             plot(steps, e_x(i,:), 'r');
%             subplot(4,4,2);
%             title('Robot 1 - y error');
%             plot(steps, e_y(i,:), 'r');
%             subplot(4,4,3);
%             title('Robot 1 - phi error');
%             plot(steps, e_dir(i,:), 'r');
%         end
%         if (s == 2)
%             subplot(4,4,1);
%             title('Robot 2 - x error');
%             plot(steps, e_x(i,:), 'g');
%             subplot(4,4,2);
%             title('Robot 2 - y error');
%             plot(steps, e_y(i,:), 'g');
%             subplot(4,4,3);
%             title('Robot 2 - phi error');
%             plot(steps, e_dir(i,:), 'g');
%         end
%         if (s == 3)
%             subplot(4,4,1);
%             plot(steps, e_x(i,:), 'b');
%             subplot(4,4,2);
%             plot(steps, e_y(i,:), 'b');
%             subplot(4,4,3);
%             plot(steps, e_dir(i,:), 'b');
%         end
%         if (s == 4)
%             subplot(4,4,1);
%             plot(steps, e_x(i,:), 'k');
%             subplot(4,4,2);
%             plot(steps, e_y(i,:), 'k');
%             subplot(4,4,3);
%             plot(steps, e_dir(i,:), 'k');
%         end
%     end






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
function visualize(Robots, Ball, colors, labels)
%VISUALIZE

% Robots:
%   Set1Robot1  Set1Robot2 ...
%   Set2Robot1  Set2Robot2 ...
%   Set3Robot1  ...           
%   ...               This allows to plot multiple states of robots at once


global Field;
global RobotParam;
global BallParam;
global Score;


%% - - - - - Field - - - - - %
    clf
    axis([-3.7 3.7 -2.7 2.7]);
    axis equal;
    rectangle('position', [-Field.width./2 -Field.height./2 Field.width Field.height],'facecolor','green');
    hold on;
    % CenterCircle
    draw_circle(0,0,Field.centerCircleRadius,'k',0);
    % Points
    draw_circle(0,0,Field.pointRadius,'k',0);
    draw_circle(-Field.width./2 + Field.penaltyPointLocation, 0, Field.pointRadius,'k',0);
    draw_circle(Field.width./2 - Field.penaltyPointLocation, 0, Field.pointRadius,'k',0);
    %Penalty Area
    rectangle('position', [ -Field.width./2 -Field.penaltyAreaHeight./2 Field.penaltyAreaWidth Field.penaltyAreaHeight]);
    rectangle('position', [ Field.width./2-Field.penaltyAreaWidth -Field.penaltyAreaHeight./2 Field.penaltyAreaWidth Field.penaltyAreaHeight]);
    %Goal
    rectangle('position', [ -Field.width./2-0.01 -Field.goalHeight./2 Field.goalWidth Field.goalHeight], 'facecolor', 'r');
    rectangle('position', [ Field.width./2-0.01 -Field.goalHeight./2 Field.goalWidth Field.goalHeight], 'facecolor', 'r');
    %Center line
    line([0, 0],[-Field.height./2, Field.height./2],'Color','k');

    
%% - - - - - Robots - - - - - %
num_sets = size(Robots, 1);

for set = 1:num_sets
    for i=1:8
        draw_circle(Robots(set,i).x, Robots(set,i).y, RobotParam.radius, colors(set,:), 1);
        if ( ~isnan(Robots(set,i).dir) )
            xdir = Robots(set,i).x + RobotParam.radius * cos(Robots(set,i).dir);
            ydir = Robots(set,i).y + RobotParam.radius * sin(Robots(set,i).dir);
            line([Robots(set,i).x xdir],[Robots(set,i).y ydir],'Color','k');
        end
        text(Robots(set,i).x, Robots(set,i).y,num2str(mod(i,4)+1));
    end
end
    
%% - - - - - Ball - - - - - %
    draw_circle(Ball.x, Ball.y, BallParam.radius, 'r', 1);
    
%% - - - - - Score - - - - - %
    text(0,2.4,[num2str(Score.blue),' : ', num2str(Score.pink)],'FontSize',16,'HorizontalAlignment','center');
end


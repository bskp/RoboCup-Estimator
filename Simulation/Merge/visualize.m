function visualize(Robot,Ball)
%VISUALIZE

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
    for i=1:8
        draw_circle(Robot(i).x, Robot(i).y, RobotParam.radius, Robot(i).color, 1);
        xdir = Robot(i).x + RobotParam.radius * cos(Robot(i).dir);
        ydir = Robot(i).y + RobotParam.radius * sin(Robot(i).dir);
        line([Robot(i).x xdir],[Robot(i).y ydir],'Color','k');
        text(Robot(i).x, Robot(i).y,num2str(mod(i,4)+1));
    end
    
%% - - - - - Ball - - - - - %
    draw_circle(Ball.x, Ball.y, BallParam.radius, 'r', 1);
    
%% - - - - - Score - - - - - %
    text(0,2.4,[num2str(Score.blue),' : ', num2str(Score.pink)],'FontSize',16,'HorizontalAlignment','center');
end


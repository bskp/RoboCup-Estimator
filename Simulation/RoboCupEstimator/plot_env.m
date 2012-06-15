function plot_env
%PLOT_ENV Plot function for the RoboCup-simulation.
%
%   PLOT_ENV plots the field according to the dimensions which are
%   used in a RoboCup soccer match. Furthermore a scorecounter will be
%   displayed above the playing field.


%----------- Defining the dimensions and subfunctions  -----------%

    axis([-3.7 3.7 -2.7 2.7]);
    axis equal;
    plot_field();
    plot_score();
end


%----------- Plot of the field  -----------%

function plot_field()

    global Field;
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
end


%----------- Plot of the scorecounter  -----------%

function plot_score()
    global Score;
    text(0,2.4,[num2str(Score.blue),' : ', num2str(Score.pink)],'FontSize',16,'HorizontalAlignment','center');
end

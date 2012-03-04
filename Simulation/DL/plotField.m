function plotField()
%plotField

    clf

% Parameters
    axis([-3.7 3.7 -2.7 2.7]);
    %Field Parameter (Rules2011.pdf)
    field_l = 6;
    field_w = 4;

    penaltyArea_l = 2.2;
    penaltyArea_w = 0.6;

    goal_l = 1.4;
    goal_w = 0.02;

    ccircle_r = 0.6;
    
    point_r = 0.05;
    penaltyPoint_x = 1.8;

%1. Field
    rectangle('position', [-field_l./2 -field_w./2 field_l field_w]);

%2. Center circle
    hold on;
    draw_circle(0,0,ccircle_r,'k',0);
    
%3. Points
    draw_circle(0,0,point_r,'k',0);
    draw_circle(-field_l./2 + penaltyPoint_x, 0, point_r,'k',0);
    draw_circle(field_l./2 - penaltyPoint_x, 0, point_r,'k',0);

%4. Penalty Area
    rectangle('position', [ -field_l./2 -penaltyArea_l./2 penaltyArea_w penaltyArea_l]);
    rectangle('position', [ field_l./2-penaltyArea_w -penaltyArea_l./2 penaltyArea_w penaltyArea_l]);

%5. Goal
    rectangle('position', [ -field_l./2-0.01 -goal_l./2 goal_w goal_l], 'facecolor', 'r');
    rectangle('position', [ field_l./2-0.01 -goal_l./2 goal_w goal_l], 'facecolor', 'r');

%6. Center line
    line([0, 0],[-field_w./2, field_w./2],'Color','k');
end


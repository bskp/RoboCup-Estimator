function PlotNS()
%PLOTNS Summary of this function goes here
%   Detailed explanation goes here

%-----Create the pitch-----%
    clf

%Parameter Pitch (Rules2011.pdf)
    global Pitch_l;
    global Pitch_w;
    %Pitch_l = 6;
    %Pitch_w = 4;
    circle_r = 0.6;
    PenaltyArea_l = 2.2;
    PenaltyArea_w = 0.6;

    Goal_l = 1.4;
    Goal_w = 0.02;

    cline_l = Pitch_w;
    cline_w = 0.01;

    PenaltyPoint_r = 0.1;


    PenaltyPointL_x = 1.8;
    PenaltyPointR_x = 4.2;
    PenaltyPoint_y = Pitch_w./2;

    circle_x = Pitch_l./2;
    circle_y = Pitch_w./2;
    
    global ball_r;
    global robot_r;


%1. Playing field fringe
    rectangle('position', [ 0 0 Pitch_l Pitch_w]);

%2. Center circle
    hold on;
    circle(circle_x,circle_y,circle_r,'k',false);


%3. Penalty Area
    rectangle('position', [ 0 0.9 PenaltyArea_w PenaltyArea_l]);
    rectangle('position', [ Pitch_l-PenaltyArea_w 0.9 PenaltyArea_w PenaltyArea_l]);

%4. Goal
    rectangle('position', [ 0 1.3 Goal_w+0.01 Goal_l], 'facecolor', 'r');
    rectangle('position', [ Pitch_l-Goal_w 1.3 Goal_w Goal_l], 'facecolor', 'r');

%4. Center line
    rectangle('position', [ (Pitch_l./2)-(cline_w./2) 0 cline_w cline_l]);

%5. Penalty points
    circle(PenaltyPointL_x,PenaltyPoint_y,PenaltyPoint_r,'k',true);
    circle(PenaltyPointR_x,PenaltyPoint_y,PenaltyPoint_r,'k',true);

%-----Creates the robots and the ball-----%
%1. Robots
    r = evalin('caller', 'r');
    for i=1:8
        circle(r(i).x,r(i).y,robot_r,'b',false);
    end

%2. Ball
    b = evalin('caller', 'b');
    circle(b.x,b.y,ball_r,'r',true);
    
    hold off;
end


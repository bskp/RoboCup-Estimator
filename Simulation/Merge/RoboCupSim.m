%    ___         __        _____          
%   / _ \ ___   / /  ___  / ___/__ __ ___ 
%  / , _// _ \ / _ \/ _ \/ /__ / // // _ \
% /_/|_| \___//_.__/\___/\___/ \_,_// .__/ Simulation
%                                  /_/    

% SETTINGS

clear all;
global dt

steps = 1e3;
dt = 0.1; %[s/step]

% Field Parameter (Rules2011.pdf)
global Field;
    Field.width = 6; %[m]
    Field.height = 4; %[m]
    Field.penaltyAreaWidth = 0.6; %[m]
    Field.penaltyAreaHeight = 2.2; %[m]
    Field.goalHeight = 1.4; %[m]
    Field.goalWidth = 0.02; %[m]
    Field.centerCircleRadius = 0.6; %[m]
    Field.pointRadius = 0.05; %[m]
    Field.penaltyPointLocation = 1.8; %[m]

%% - - - - - Initalization - - - - - %
global RobotParam;
global BallParam;
    
    Robot = dummy_init();
    Ball = ball_init();
    visualize(Robot,Ball)

%% - - - - - Loop - - - - - %
for s = 1:steps
    Robot = dummy_step(Robot);
    Ball = ball_step(Ball,Robot);
    visualize(Robot,Ball);
    pause(0.005);
end

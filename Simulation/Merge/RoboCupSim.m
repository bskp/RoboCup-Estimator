%    ___         __        _____          
%   / _ \ ___   / /  ___  / ___/__ __ ___ 
%  / , _// _ \ / _ \/ _ \/ /__ / // // _ \
% /_/|_| \___//_.__/\___/\___/ \_,_// .__/ Simulation
%                                  /_/    

% SETTINGS

clear all;
global dt;

steps = 2e3;
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
    
    
global Noise;
    Noise.process.pos = 1e-2 *dt; % [m/step]
    Noise.process.dir = 1e-2 * 2*pi *dt; %[rad/step]
    
    Noise.measure.pos = 1e-1; %[m]

%% - - - - - Initalization - - - - - %
figure('units','normalized','position',[0.1,0,0.4,0.9]);
colorcode;

global RobotParam;
global BallParam;
global Score;
    Score.blue = 0;
    Score.pink = 0;
    
    Robot = dummy_init();
    Robot_estimate = Robot;
    %P = 0;
    Ball = ball_init();

%% - - - - - Loop - - - - - %
for s = 1:steps
    Robot = dummy_step(Robot);
    Ball = ball_step(Ball,Robot);
    Robot_m = dummy_measure(Robot);
    %[Robot_estimate P] = ext_kalman_filter(Robot_estimate, P);
    
    clf
    subplot(2,1,1)
    plot_env(Ball);

    plot_robot(Robot, '0-t'); % circles, direction, team color
    plot_robot(Robot_m, '+w'); % crosses, black
    
    subplot(2,1,2)
    plot_env(Ball);
    %plot_robot(Robot_estimate, '0-t');
    plot_robot(Robot_m, '+w');
    
    pause(0.001);
end

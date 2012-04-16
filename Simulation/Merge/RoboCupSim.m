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
    Noise.process.pos = 1e-4 *dt; %[m/step]
    Noise.process.dir = 1e-4 * 2*pi *dt; %[rad/step]
    
    Noise.measure.pos = 1e-1; %[m]
    Noise.measure.dir = 1e-1 * 2*pi; %[rad]
    
    Noise.measure.prob = 0.2;

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
    for i = 1:8
        P(:,:,i) = eye(3);
    end
    Ball = ball_init();
    m_values = 0;
    e_values = 0;

%% - - - - - Loop - - - - - %
for s = 1:steps
    [Robot d_omega v] = dummy_step(Robot);
    Ball = ball_step(Ball,Robot);
    Robot_m = dummy_measure(Robot);
    [Robot_estimate P] = ext_kalman_filter(Robot_m, Robot_estimate, m_values, e_values, d_omega, v, P);
    
    clf
    subplot(2,1,1)
    plot_env(Ball);

    plot_robot(Robot, '0-t'); % circles, direction, team color
    plot_robot(Robot_m, '+w'); % crosses, white
    
    subplot(2,1,2)
    plot_env(Ball);
    plot_robot(Robot, '@-t');    
    plot_robot(Robot_estimate, '0-k');
    
    if(s==1)
        [m_values e_values] = history_init(Robot_m, Robot_estimate);
    end
    [m_values e_values] = history(m_values, e_values, Robot_m, Robot_estimate);
    
    pause(0.001);
end

%    ___         __        _____          
%   / _ \ ___   / /  ___  / ___/__ __ ___ 
%  / , _// _ \ / _ \/ _ \/ /__ / // // _ \
% /_/|_| \___//_.__/\___/\___/ \_,_// .__/ Simulation
%                                  /_/    

% SETTINGS

clear all;
global dt;

steps = 200;
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
    Noise.measure.sigma1 = 1;
    Noise.measure.sigma2 = 1.15;
    Noise.measure.sigma3 = 1.3;
    
    Noise.measure.prob = 0.2;

%% - - - - - Initalization - - - - - %
close all;
figure('units','normalized','position',[0.1,0,0.4,0.9]);
colorcode;

global RobotParam;
global BallParam;
global Score;
    Score.blue = 0;
    Score.pink = 0;
    
Robot = robot_init();
Robot_e = Robot;
for i = 1:8
    P(:,:,i) = eye(3);
end
P_ball = eye(4);
Ball = ball_init();
Ball_e = Ball;
m_values = 0;
e_values = 0;
v_pink = ones(1,4)*RobotParam.velocity;

%% - - - - - Loop - - - - - %
for s = 1:steps
    [Robot d_angle v] = robot_step(Robot, Ball);
    Ball = ball_step(Ball,Robot);
    Robot_m = robot_measure(Robot);
    Ball_m = ball_measure(Robot, Ball);
    
    [Ball_e P_ball] = ball_kf(Ball_e, Ball_m, P_ball);
    [Robot_e P v_pink] = robot_ekf(Robot_m, Robot_e, m_values, e_values, d_angle, v, v_pink, P);
    
    clf
    subplot(2,1,1)
    plot_env;

    plot_objects(Robot, Ball, '0-t'); % circles, direction, team color
    plot_objects(Robot_m, Ball_m, '+w'); % crosses, white
    
    subplot(2,1,2)
    plot_env;
    plot_objects(Robot, Ball, '@-t');    
    plot_objects(Robot_e, Ball_e, '0-w');
    
    if(s==1)
        [m_values e_values] = history_init(Robot_m, Robot_e);
    end
    [m_values e_values] = history(m_values, e_values, Robot_m, Robot_e);
    
    pause(0.001);
    
    save_results; % Save the designated results of the simulation to a .mat file

end
%    ___         __        _____          
%   / _ \ ___   / /  ___  / ___/__ __ ___ 
%  / , _// _ \ / _ \/ _ \/ /__ / // // _ \
% /_/|_| \___//_.__/\___/\___/ \_,_// .__/ Simulation
%                                  /_/    

% SETTINGS

clear all;

steps = 100;
video_on = true;
% hint for videos: if the animation is stopped by ctr-c, you need to 
% close the video Object manually through:
% close(vidObj)

global dt;
dt = 0.1; %[s/step]

% Choice of Models
robotInitMdl = 'robot_standard';
robot_init = str2func( [robotInitMdl '_init'] );

robotMdl = 'robot_randpot';  % Robot Model to use
robot_step = str2func( [robotMdl '_step'] );

measureMdl = 'robot_sight_of_view'; % Measurement Model to use
robot_measure = str2func( [measureMdl '_measure'] );

filterMdl = 'robot_extended_kalman'; % Filter Model to use
robot_filter = str2func( [filterMdl '_filter'] );

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
    Noise.Process.pos = 1e-4 *dt; %[m/step]
    Noise.Process.dir = 1e-4 * 2*pi *dt; %[rad/step]
    
    Noise.Measure.pos = 1e-1; %[m]
    Noise.Measure.dir = 1e-1 * 2*pi; %[rad]
    Noise.Measure.sigma1 = 1;
    Noise.Measure.sigma2 = 1.15;
    Noise.Measure.sigma3 = 1.3;
    
    Noise.Measure.prob = 0.2;

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
RobotEstimate = Robot;
for i = 1:8
    P(:,:,i) = eye(3);
end
Pball = eye(4);
Ball = ball_init();
BallEstimate = Ball;
mValues = 0;
eValues = 0;
vPink = ones(1,4)*RobotParam.velocity;

% VIDEO
if(video_on)
vidObj= VideoWriter(['videos/estimator ' datestr(now) '.avi']);
set(vidObj,'FrameRate',10);
set(vidObj,'Quality',90);
open(vidObj);
end

%% - - - - - Loop - - - - - %
for s = 1:steps
    [Robot dAngle v] = robot_step(Robot, Ball);
    Ball = ball_step(Ball,Robot);
    RobotMeasure = robot_measure(Robot);
    BallMeasure = ball_measure(Robot, Ball);
    
    [RobotEstimate P vPink] = robot_filter(RobotMeasure, RobotEstimate, ...
        mValues, eValues, dAngle, v, vPink, P);
    [BallEstimate Pball] = ball_ekf(BallEstimate, BallMeasure, Pball);
      
    clf
    h1 = subplot(2,1,1);
    plot_env;
    plot_objects(Robot, Ball, '0-tV'); % circles, direction, team color
    plot_objects(RobotMeasure, BallMeasure, '+k'); % crosses, black
    
    h2 = subplot(2,1,2);
    plot_env;
    plot_objects(Robot, Ball, '@-t');    
    plot_objects(RobotEstimate, BallEstimate, '0-w');
    
    if(s==1)
        [mValues eValues] = history_init(RobotMeasure, RobotEstimate);
    else
        [mValues eValues] = history(mValues, eValues, RobotMeasure, ...
            RobotEstimate);
    end
    
    pause(0.001);
    
    if (video_on)
        fig1=getframe(h1);
        fig2=getframe(h2);
        currentFrame.colormap = [];
        currentFrame.cdata = [fig1.cdata; fig2.cdata];
        writeVideo(vidObj,currentFrame);
    end
    
    save_results; % Save the designated results of the simulation to a .mat file

end

if (video_on)
close(vidObj);
end 
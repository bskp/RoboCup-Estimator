function RoboCupSim(cycles)
%randSim Simulates a RoboCup game
%   cycles  Number of simulation cycles

%-----Global variables/variables-----%
    global Pitch_l;
    global Pitch_w;
    global step_max;
    global ball_r;
    global robot_r;

    Pitch_l = 6;
    Pitch_w = 4;
    step_max = 0.1;
    ball_r = 0.065./2;
    robot_r = 0.1;
    
    p = 0.2;

%-----Creating the initial situation-----%
%Initialization Robots and ball
    for i=1:8      %Anzahl Roboter
        r(i) = struct('x', (Pitch_l./2)*rand, 'y', Pitch_w*rand, 'phi', 2*pi*rand);
        %r(i+5) = struct('x', (Pitch_l./2)*rand+(Pitch_l./2), 'y', Pitch_w*rand, 'phi', 2*pi*rand);
    end
    assignin('caller', 'r', r);
    
    b = struct('x', (Pitch_l./2)*rand, 'y', Pitch_w*rand);
    assignin('caller', 'b', b);

%Initialization-Plot
    PlotNS;

%-----Simulation cycle-----%
    for j=1:cycles
        assignin('caller', 'r', r);
        assignin('caller', 'b', b);
        for k=1:8
            r = randRobot(k);
        end
        b = randBall;
        pause(p);
        PlotNS;
        
    end
end


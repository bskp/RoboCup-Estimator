%% ------------------------------------------------------------------
%                      Setting global variables
%  ------------------------------------------------------------------

upm = 80;                   % upm means units per meter
length = 6*upm;             % Length of the playing area
width = 4*upm;              % Width of the playing area


%% ------------------------------------------------------------------
%                       Initializing the robots
%  ------------------------------------------------------------------

blue_robot_1 = struct('x',{upm},'y',{upm},'angle',{0},'color',{'blue'});
blue_robot_2 = struct('x',{2*upm},'y',{1.5*upm},'angle',{0},'color',{'blue'});
blue_robot_3 = struct('x',{3*upm},'y',{upm},'angle',{0},'color',{'blue'});
blue_keeper = struct('x',{2*upm},'y',{0.5*upm},'angle',{0},'color',{'blue'});

pink_robot_1 = struct('x',{upm},'y',{5*upm},'angle',{0},'color',{'pink'});
pink_robot_2 = struct('x',{2*upm},'y',{4.5*upm},'angle',{0},'color',{'pink'});
pink_robot_3 = struct('x',{3*upm},'y',{5*upm},'angle',{0},'color',{'pink'});
pink_keeper = struct('x',{2*upm},'y',{5.5*upm},'angle',{0},'color',{'pink'});


%% ------------------------------------------------------------------
%                        Initializing the ball
%  ------------------------------------------------------------------

ball = struct('x',{2*upm},'y',{3*upm},'angle',{-pi/2},'velocity',{3},'color',{'orange'});


%% ------------------------------------------------------------------
%                         Start simulation
%  ------------------------------------------------------------------
steps = 1000;

b_players = [blue_robot_1,blue_robot_2,blue_robot_3,blue_keeper];
p_players = [pink_robot_1,pink_robot_2,pink_robot_3,pink_keeper];
players = [b_players, p_players];
[m,n] = size(players);

for i=1:steps
    for j=1:n
        players(j) = robot(players(j), width, length);
    end
    ball = ball_sim(ball);
    A = field(players, ball, width, length, upm);
    image(A);
    colorcode;
    pause(0.01);
end








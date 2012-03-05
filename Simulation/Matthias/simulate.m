%    ___         __        _____          
%   / _ \ ___   / /  ___  / ___/__ __ ___ 
%  / , _// _ \ / _ \/ _ \/ /__ / // // _ \
% /_/|_| \___//_.__/\___/\___/ \_,_// .__/ Dummy data
%                                  /_/    

% SETTINGS

clear all;

steps = 100;

num_players = 6;
field.width = 6; % m
field.height = 4; % m

% INIT

player = struct('team', {}, 'x', {}, 'y', {}, 'dir', {});

dummy_init;
ball_init;

% GO

for s = 1:steps
    
    dummy_step;
    ball_step;
    
    
    %collide;
    
    visualize;
    pause(0.1);
end

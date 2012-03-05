function [player] = robot(player, width, length)
%ROBOT   The function takes a robot struct as an argument, manipulates its
%        properties like the position or the angle and finally outputs
%        the manipulated struct. The arguments width and length are used,
%        to check the boundaries of the field.

%% ----------------------------------------------------------------------
%             Compute incremental values and check boundaries
%  ----------------------------------------------------------------------

dx = (rand(1)-0.5)*6;               % Robot can change its x-position
                                    % within the interval (-3,+3)
dy = (rand(1)-0.5)*6;               % Robot can change its y-position
                                    % within the interval (-3,+3)
dangle = (rand(1)-0.5)*0.25*pi;     % Robot can change its angle within
                                    % the interval (-22.5°,+22.5°)
                                    
% If boundaries are violated, we simply change the sign of the incremental
% values

x = player.x;                       % Reading the players x position
y = player.y;                       % Reading the players y position

if(x+dx < 0 || x+dx > width)
    dx = -dx;
end

if(y+dy < 0 || y+dy > length)
    dy = -dy;
end
                                    
                                    
%% ----------------------------------------------------------------------
%                     Compute new position and angle
%  ----------------------------------------------------------------------
                                    
player.x = x + dx;
player.y = y + dy;
player.angle = player.angle + dangle;

end


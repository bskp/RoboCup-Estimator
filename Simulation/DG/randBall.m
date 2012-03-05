function b = randBall()
%RANDBALL Summary of this function goes here
%   Detailed explanation goes here

    global Pitch_l;
    global Pitch_w;

    global step_max;
    global ball_r;
    
    b = evalin('caller', 'b');

%-----Calculating next position and angle of the robot-----%
    dx = step_max.*((-1)+2.*rand);
    dy = step_max.*((-1)+2.*rand);
    while(((b.x+dx+ball_r) < Pitch_l) && ((b.y+dy+ball_r) < Pitch_w) && (0 < (b.y+dy-ball_r)) && (0 < (b.x+dx-ball_r)) == 0)
        %dx = step_max.*rand;
        %dy = step_max.*rand;
        %dphi = phi_max.*rand;
        dx = step_max.*((-1)+2.*rand);
        dy = step_max.*((-1)+2.*rand);
    end
    b.x = b.x + dx;
    b.y = b.y + dy;
end


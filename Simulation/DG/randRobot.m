function r = randRobot(k)
%function randRobot(struct *r, Pitch_l, Pitch_w)
%randRobot Summary of this function goes here
%   r           Array of structs of the robots
%   Pitch_l     Lenght of the pitch
%   Pitch_w     Width of the pitch


    global Pitch_l;
    global Pitch_w;

    phi_max = 10;
    step_max = 0.1;
    r = evalin('caller', 'r');

%-----Calculating next position and angle of the robot-----%
    dx = step_max*rand;
    dy = step_max*rand;
    dphi = phi_max*rand;
    while((r(k).x + dx < Pitch_l) && (r(k).y + dy < Pitch_w) == 0)
        dx = step_max*rand;
        dy = step_max*rand;
        dphi = phi_max*rand;
    end
    r(k).x = r(k).x + dx;
    r(k).y = r(k).y + dy;
    r(k).phi = r(k).phi + dphi;
end


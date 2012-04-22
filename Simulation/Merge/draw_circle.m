function draw_circle(pos_x, pos_y, r, color, filled)
%DRAW_CIRCLE Drawing function.
%
%   DRAW_CIRCLE(POS_X,POS_Y,R,COLOR,FILLED) draws objects, like the ball or
%   the robots, at the position (POS_X,POS_Y) on the playing field. The
%   objects are represented by circles with radius R and the color given by
%   the parameter COLOR. The flag FILLED is used to specify whether the 
%   circles are filled with a given color or not.

xl = xlim;      % Store limits in order to avoid dynamic alignment of the
yl = ylim;      % field.


%----------- Define unitcircle -----------%

phi=linspace(0,2*pi,48);
x=cos(phi);
y=sin(phi);


%----------- Draw circle -----------%

if filled == 1
    fill(pos_x + r*x,pos_y + r*y,color);
else
    plot(pos_x + r*x,pos_y + r*y,'Color',color);
end
    

xlim(xl);
ylim(yl);

end


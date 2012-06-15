function draw_circle(x, y, r, color, isFilled)
%DRAW_CIRCLE Drawing function for circles.
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
dx = cos(phi);
dy = sin(phi);


%----------- Draw circle -----------%

if isFilled == 1
    fill(x + r*dx,y + r*dy,color);
else
    plot(x + r*dx,y + r*dy,'Color',color);
end
    

xlim(xl);
ylim(yl);

end


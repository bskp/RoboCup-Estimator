function draw_circle(pos_x, pos_y, r, color, filled)
%DRAW_CIRCLE

xl = xlim;      % Originalgrösse merken
yl = ylim;

phi=linspace(0,2*pi,48);
x=cos(phi);
y=sin(phi);

if filled == 1
    fill(pos_x + r*x,pos_y + r*y,color);
else
    plot(pos_x + r*x,pos_y + r*y,color);
end
    
xlim(xl);
ylim(yl);

end


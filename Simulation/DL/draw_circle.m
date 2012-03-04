function draw_circle(Pos_x,Pos_y,r,color,filled)
%DRAW_CIRCLE

%xl = xlim;      % Originalgrösse merken
%yl = ylim;
phi=linspace(0,2*pi);
x=cos(phi);
y=sin(phi);

if filled == 1
    fill(Pos_x + r*x,Pos_y + r*y,color);
else
    plot(Pos_x + r*x,Pos_y + r*y,color);
%xlim(xl);
%ylim(yl);

end


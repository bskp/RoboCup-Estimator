function cyrcle(Pos_x,Pos_y,r)
%CYRCLE Summary of this function goes here
%   Detailed explanation goes here

xl = xlim;      % Originalgrösse merken
yl = ylim;

phi=linspace(0,2*pi);
x=cos(phi);
y=sin(phi);

plot(Pos_x + r*x,Pos_y + r*y, 'b');

xlim(xl);
ylim(yl);

end


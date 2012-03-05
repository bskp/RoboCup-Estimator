function circle(Pos_x, Pos_y ,r , plotColor,filled)
%CYRCLE Summary of this function goes here
%   Detailed explanation goes here

    xl = xlim;      % Originalgrösse merken
    yl = ylim;

    phi=linspace(0,2*pi);
    x=cos(phi);
    y=sin(phi);
    
    if(filled == true)
        fill(Pos_x + r*x,Pos_y + r*y, plotColor);
        %r_var = linspace(0,r);
        %for i=1:100
            %plot(Pos_x + r_var(i)*x,Pos_y + r_var(i)*y, plotColor);
        %end
    else
        plot(Pos_x + r*x,Pos_y + r*y, plotColor);
        %plot(Pos_x + r*x,Pos_y + r*y, 'b');
    end

    xlim(xl);
    ylim(yl);

end


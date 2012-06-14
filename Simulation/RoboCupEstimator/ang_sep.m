function [ sep ] = ang_sep( x, y )
%ANG_SEP separation by angles.
%   Detailed explanation goes here

    dx = x(2:end) - x(1:end-1);
    dy = y(2:end) - y(1:end-1);
    
    ang = atan(dy./dx);
    w = hypot(dx,dy);
    
    n = length(dx);
    
    r = 0;
    for i = 1:n
        t.m1 = sum( ang(1:i).*w(1:i) );
        t.m2 = sum( ang(i:end).*w(i:end) );
        t.r = abs(t.m2 - t.m1); % bewertungsfunktion
        if (t.r > r)
            r = t.r;
            m1 = t.m1;
            m2 = t.m2;
            sep = i;
        end
    end
    
    %plot((x(1:end-1)+x(2:end))/2, ang, 'o' );
    %plot(x,y, 'r');
    
        if (true)
        hold on;
        axis equal;
        plot(x(1:sep-1),y(1:sep-1), 'or');
        plot(x(sep),y(sep), 'ok');
        plot(x(sep+1:n),y(sep+1:n), 'ob');
        %plot([0;1], [b1,m1+b1], 'r');
        %plot([0;1], [b2,m2+b2], 'b');
        hold off;
    end

end


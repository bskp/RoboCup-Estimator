function [ sep, r, m1, b1, m2, b2 ] = reg_sep( x, y, draw_plot )
%reg_sep Regressional separation of data into two linearly correlating sets
%   ...
    
    if (nargin == 2)
        draw_plot = false;
    end

    n = length(x);
    if (n ~= length(y))
        error('x- and y-dataset must be of same length.');
    end
    
    r = inf;
    
    for i = 1:n
        [t.r1,t.m1,t.b1] = regression( x(1:i), y(1:i) );
        [t.r2,t.m2,t.b2] = regression( x(i:n), y(i:n) );
        t.r = t.r1+t.r2;
        if (t.r < r)
            r = t.r;
            m1 = t.m1;
            m2 = t.m2;
            b1 = t.b1;
            b2 = t.b2;
            sep = i;
        end
    end
    
    if (draw_plot)
        hold on;
        axis equal;
        plot(x(1:sep-1),y(1:sep-1), 'or');
        plot(x(sep),y(sep), 'ok');
        plot(x(sep+1:n),y(sep+1:n), 'ob');
        plot([0;1], [b1,m1+b1], 'r');
        plot([0;1], [b2,m2+b2], 'b');
        hold off;
    end

end


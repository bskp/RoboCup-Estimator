function plot_char_points()
%PLOT_CHAR_POINTS Plot function for the charactersistc pionts

    global Field;

    %Characteristic points (Corners, half-wayline corners, goals and center)
    CharPoint(1) = struct('x', Field.width./2, 'y', Field.height./2);
    CharPoint(2) = struct('x', -Field.width./2, 'y', Field.height./2);
    CharPoint(3) = struct('x', Field.width./2, 'y', -Field.height./2);
    CharPoint(4) = struct('x', -Field.width./2, 'y', -Field.height./2);
    CharPoint(5) = struct('x', 0, 'y', Field.height./2);
    CharPoint(6) = struct('x', 0, 'y', -Field.height./2);
    CharPoint(7) = struct('x', Field.width./2, 'y', 0);
    CharPoint(8) = struct('x', -Field.width./2, 'y', 0);     
    CharPoint(9) = struct('x', 0, 'y', 0);

    for i = 1:9
        draw_circle(CharPoint(i).x,CharPoint(i).y,0.05,'y',1)
    end
end


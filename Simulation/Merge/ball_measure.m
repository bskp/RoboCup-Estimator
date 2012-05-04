function Ball_m = ball_measure( Ball )
%BALL_MEASURE Determines wheter the ball is measurable and adds process
%noise

    global Noise; % Let's just assume the same noise values as for robots
    
    Ball_m.x = NaN;
    Ball_m.y = NaN;
    Ball_m.dir = NaN;
    Ball_m.velocity = NaN;
    
    if (ball_is_visible)
        Ball_m.x = Ball.x + randn*Noise.measure.pos;
        Ball_m.y = Ball.y + randn*Noise.measure.pos;
    end

end

function biv = ball_is_visible()
    biv = (rand < 0.8); % to be replaced later with the vis-check-function
    biv = true;
end
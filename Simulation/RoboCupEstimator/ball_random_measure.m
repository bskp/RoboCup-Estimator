function BallMeasure = ball_random_measure(Ball)
%BALL_RANDOM_MEASURE Addition of measurement noise to the ball.
%
%   BALLMEASURE = BALL_RANDOM_MEASURE(BALL) takes the parameter BALL
%   and adds measurement noise to the position and the direction of it.
%   A new ball is created with the noisy measurements.
%   Furthermore, with a certain probability, the measurement is dropped


%----------- Create normally distributed noise  -----------%

    global Noise;
    Noise.Measure.prob = 0.2; % Probability for Measurement drop
    d = randn(1,3); % Noise values
    p = rand(1,1);  % Measurement-probability-deciders
    
    
%----------- Adding noise to the parameters -----------%
        
    if ( p(i) > Noise.Measure.prob )

        BallMeasure(i).x = Ball.x + d(1)*Noise.Measure.pos;
        BallMeasure(i).y = Ball.y + d(2)*Noise.Measure.pos;
        BallMeasure(i).dir = Ball.dir + d(3)*Noise.Measure.dir;
        BallMeasure(i).sigma = 1;

    else

        BallMeasure(i).x = NaN;    % Measurement drop
        BallMeasure(i).y = NaN;
        BallMeasure(i).dir = NaN;
        BallMeasure(i).sigma = NaN;

    end
end
function BallMeasure = ball_optimistic_measure(Robot, Ball)
%BALL_RANDOM_MEASURE Addition of measurement noise to the ball.
%
%   BALLMEASURE = BALL_RANDOM_MEASURE(BALL) takes the parameter BALL
%   and adds measurement noise to the position and the direction of it.
%   A new ball is created with the noisy measurements.

%----------- Create normally distributed noise  -----------%

    global Noise;
    d = randn(1,3); % Noise values

%----------- Adding noise to the parameters -----------%

    BallMeasure.x = Ball.x + d(1)*Noise.Measure.pos;
    BallMeasure.y = Ball.y + d(2)*Noise.Measure.pos;
    BallMeasure.dir = Ball.dir + d(3)*Noise.Measure.dir;
    BallMeasure.sigma = 1;
end
function ball = ball_sim(ball)
%BALL   The function ball_sim computes the movement of the ball-object

ball.x = ball.x+ball.velocity*cos(ball.angle);
ball.y = ball.y+ball.velocity*sin(ball.angle);
ball.velocity = ball.velocity*0.97;

end


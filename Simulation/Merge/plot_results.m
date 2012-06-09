%PLOT_RESULTS Plots the estimation error of the robots and the ball.
%   Detailed explanation goes here  


% Initialisierung

    clf;

% Create a txt-File with data from robots and the estimation

    load('error', 'steps');
    load('error', 'RobotStep');
    load('error', 'RobotStep_e');
    load('error', 'BallStep');
    load('error', 'BallStep_e');


% Calculation of error for every Robot and the ball

    for s=1:steps
        for i=1:8
            Robot = RobotStep(s,1,i);
            Robot_e = RobotStep_e(s,1,i);
         
            e_x(i,s) = abs(Robot.x-Robot_e.x);
            e_y(i,s) = abs(Robot.y-Robot_e.y);
            e_dir(i,s) = abs(Robot.dir-Robot_e.dir);
        end
        % Calculation of error for the ball
        Ball = BallStep(s);
        Ball_e = BallStep_e(s);
        
        e_x(9,s) = abs(Ball.x-Ball_e.x);
        e_y(9,s) = abs(Ball.y-Ball_e.y);
        e_dir(9,s) = abs(Ball.dir-Ball_e.dir);
    end





% Plot of the estimation error of the robots

%   pcolor(1) = 'r';
%   pcolor(2) = 'g';
%   pcolor(3) = 'b';
%   pcolor(4) = 'k';

    x = linspace(1, steps, steps);

    for j=1:8
        if (j<=4)
            figure(1);
            i = j;
        else
            figure(2);
            i = j-4;
        end
        subplot(4,2,2*i-1);
        plot(x, e_x(j,:), 'r');
        hold on;
        plot(x, e_y(j,:), 'g');
        grid on;
        titleString = ['Robot ' num2str(j)];
        title(titleString);
        if ((j==1) || (j==5))
            xlabel('steps');
            ylabel('estimation error of directions [m]');
            legend('direction x', 'direction y', 0);
        end
    
        subplot(4,2,2*i);
        plot(x, e_dir(j,:), 'b');
        grid on;
        titleString = ['Robot ' num2str(j)];
        title(titleString);
        if ((j==1) || (j==5))
            xlabel('steps');
            ylabel('estimation error of angle [rad]');
            legend('Angle phi', 0);
        end
    end
    
    
% Plot of the estimation error of the ball

    figure(3);
    
    subplot(1,2,1);
    plot(x, e_x(9,:), 'r');
    hold on;
    plot(x, e_y(9,:), 'g');
    grid on;
    title('Ball');
    xlabel('steps');
    ylabel('estimation error of directions [m]');
    legend('Direction x', 'Direction y');
    
    subplot(1,2,2);
    plot(x, e_dir(9,:), 'b');
    grid on;
    title('Ball');
    xlabel('steps');
    ylabel('estimation error of angle [rad]');
    legend('Angle phi');
    
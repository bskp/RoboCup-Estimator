%PLOT_RESULTS Plots the estimation error of the robots and the ball and
%plots the norm of the P matrix.
%   Detailed explanation goes here  


% Initialization

    clf;

% Load data

    load('plot', 'steps');
    load('plot', 'sRobot');
    load('plot', 'sRobotEstimate');
    load('plot', 'sBall');
    load('plot', 'sBallEstimate');

    load('plot', 'sPnorm');
    load('plot', 'sPballNorm');
    load('plot', 'sKnorm');
    load('plot', 'sKBnorm');

% Calculation of error for every Robot and the ball

    for s=1:steps
        for i=1:8
            Robot = sRobot(s,1,i);
            RobotEstimate = sRobotEstimate(s,1,i);
         
            ex(i,s) = abs(Robot.x-RobotEstimate.x);
            ey(i,s) = abs(Robot.y-RobotEstimate.y);
            edir(i,s) = abs(Robot.dir-RobotEstimate.dir);
        end
        % Calculation of error for the ball
        Ball = sBall(s);
        BallEstimate = sBallEstimate(s);
        
        ex(9,s) = abs(Ball.x-BallEstimate.x);
        ey(9,s) = abs(Ball.y-BallEstimate.y);
        edir(9,s) = abs(Ball.dir-BallEstimate.dir);
    end


% Plot of the estimation error and the norm of the P matrix of the robots

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
        plot(x, ex(j,:), 'r');
        hold on;
        %plot(x, e_y(j,:), 'g');
        %plot(x, P_det(j,:), 'k');
        %[AX,H1,H2] = plotyy(x, ey(j,:), x, sPnorm(j,:));
        [AX,H1,H2] = plotyy(x, ey(j,:), x, sKnorm(j,:));
        set(H2,'LineStyle','--', 'LineWidth', 1.2);
        grid on;
        titleString = ['Robot ' num2str(j)];
        title(titleString);
        if ((j==1) || (j==5))
            xlabel('steps');
            %ylabel('estimation error of directions [m]');
            set(get(AX(1),'Ylabel'),'String','estimation error of directions [m]');
            set(get(AX(2),'Ylabel'),'String','Norm of matrix P');
            legend('direction x', 'direction y', 'Norm P matrix', 0);
        end
    
        subplot(4,2,2*i);
        %plot(x, e_dir(j,:), 'b');
        %[AX,H1,H2] = plotyy(x, edir(j,:), x, sPnorm(j,:));
        [AX,H1,H2] = plotyy(x, edir(j,:), x, sKnorm(j,:));
        set(H1,'Color', 'k');
        set(H2,'LineStyle','--', 'LineWidth', 1.2);
        grid on;
        titleString = ['Robot ' num2str(j)];
        title(titleString);
        if ((j==1) || (j==5))
            xlabel('steps');
            %ylabel('estimation error of angle [rad]');
            set(get(AX(1),'Ylabel'),'String','estimation error of angle [rad]') 
            set(get(AX(2),'Ylabel'),'String','Norm of matrix P') 
            legend('Angle phi', 'Norm P matrix', 0);
        end
    end
    
    
% Plot of the estimation error and the norm of the P matrix of the ball

    figure(3);
    
    subplot(1,2,1);
    plot(x, ex(9,:), 'r');
    hold on;
    %plot(x, e_y(9,:), 'g');
    %[AX,H1,H2] = plotyy(x, ey(9,:), x, sPballNorm(:));
    [AX,H1,H2] = plotyy(x, ey(9,:), x, sKBnorm(:));
    set(H2,'LineStyle','--', 'LineWidth', 1.2);
    grid on;
    title('Ball');
    xlabel('steps');
    %ylabel('estimation error of directions [m]');
    set(get(AX(1),'Ylabel'),'String','estimation error of directions [m]');
    set(get(AX(2),'Ylabel'),'String','Norm of matrix P');
    legend('Direction x', 'Direction y', 'Norm P matrix');
    
    subplot(1,2,2);
    %plot(x, e_dir(9,:), 'b');
    %[AX,H1,H2] = plotyy(x, edir(9,:), x, sPballNorm(:));
    [AX,H1,H2] = plotyy(x, edir(9,:), x, sKBnorm(:));
    set(H1,'Color', 'k');
    set(H2,'LineStyle','--', 'LineWidth', 1.2);
    grid on;
    title('Ball');
    xlabel('steps');
    %ylabel('estimation error of angle [rad]');
    set(get(AX(1),'Ylabel'),'String','estimation error of angle [rad]') 
    set(get(AX(2),'Ylabel'),'String','Norm of matrix P') 
    legend('Angle phi', 'Norm P matrix');
    
% Maximize Plot
    for i=1:3
        figure(i) 
        set(figure(i),'units','normalized','outerposition',[0 0 1 1]);
    end
    
    
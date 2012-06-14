%PLOT_RESULTS Plots the estimation error of the robots and the ball and
%plots the norm of the P matrix.
%   Detailed explanation goes here  


% Initialization

    clf;

% Load data

    load('plot', 'steps');
    load('plot', 'sRobot');
    load('plot', 'sRobot_e');
    load('plot', 'sBall');
    load('plot', 'sBall_e');

    load('plot', 'sP_norm');
    load('plot', 'sP_ball_norm');

% Calculation of error for every Robot and the ball

    for s=1:steps
        for i=1:8
            Robot = sRobot(s,1,i);
            Robot_e = sRobot_e(s,1,i);
         
            e_x(i,s) = abs(Robot.x-Robot_e.x);
            e_y(i,s) = abs(Robot.y-Robot_e.y);
            e_dir(i,s) = abs(Robot.dir-Robot_e.dir);
        end
        % Calculation of error for the ball
        Ball = sBall(s);
        Ball_e = sBall_e(s);
        
        e_x(9,s) = abs(Ball.x-Ball_e.x);
        e_y(9,s) = abs(Ball.y-Ball_e.y);
        e_dir(9,s) = abs(Ball.dir-Ball_e.dir);
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
        plot(x, e_x(j,:), 'r');
        hold on;
        %plot(x, e_y(j,:), 'g');
        %plot(x, P_det(j,:), 'k');
        [AX,H1,H2] = plotyy(x, e_y(j,:), x, sP_norm(j,:));
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
        [AX,H1,H2] = plotyy(x, e_dir(j,:), x, sP_norm(j,:));
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
    plot(x, e_x(9,:), 'r');
    hold on;
    %plot(x, e_y(9,:), 'g');
    [AX,H1,H2] = plotyy(x, e_y(9,:), x, sP_norm(j,:));
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
    [AX,H1,H2] = plotyy(x, e_dir(9,:), x, sP_norm(j,:));
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
    
    
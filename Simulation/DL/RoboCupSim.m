function  RoboCupSim(steps)
%RoboCupRandomSim

%Init
    RedRobots(1) = struct('X',-1,'Y',-1,'Theta',0);
    RedRobots(2) = struct('X',-1,'Y',0,'Theta',0);
    RedRobots(3) = struct('X',-1,'Y',1,'Theta',0);

    BlueRobots(1) = struct('X',1,'Y',-1,'Theta',pi);
    BlueRobots(2) = struct('X',1,'Y',0,'Theta',pi);
    BlueRobots(3) = struct('X',1,'Y',1,'Theta',pi);

    Ball =  struct('X',0,'Y',0,'Theta',pi./2,'V',1);

%Loop
    for i=1:steps
        %Plots
        plotField();
        plotRobots(RedRobots,BlueRobots,Ball); 

        %Step
        [RedRobots,BlueRobots,Ball] = RandomStep(RedRobots,BlueRobots,Ball);
        pause(0.01);
    end
    

end


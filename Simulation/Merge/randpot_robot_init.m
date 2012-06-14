function Robot = randpot_robot_init()
%ROBOT_INIT Initializes eight sighted robots.
%
%   ROBOT = ROBOT_INIT() generates structs for eight robots, including
%   information about their position, their direction and their team
%   affiliation. Furthermore there are global variables which define for
%   example their size on the field, their sight distance or their sight
%   angle.


%----------- Init of global variables -----------%

    global RobotParam dt;
    RobotParam.radius = 0.15; %[m]
    RobotParam.velocity = 0.1 *dt; %[m/s]
    RobotParam.changeOfDir = 0.1 * 2*pi *dt; %[rad/s], exp. value
    RobotParam.sightDistance = 2.5; %[m]
    RobotParam.sightAngle = pi./6; %[rad]

    
%----------- Init of robot parameters -----------%
    
    Robot(1) = struct('color', 'blue', 'x', -1, 'y', -1, 'dir', 0);
    Robot(2) = struct('color', 'blue', 'x', -1, 'y', 0, 'dir', 0);
    Robot(3) = struct('color', 'blue', 'x', -1, 'y', 1, 'dir', 0);
    Robot(4) = struct('color', 'blue', 'x', -2.5, 'y', 0, 'dir', 0);
    Robot(5) = struct('color', 'magenta', 'x', 1, 'y', -1, 'dir', pi);
    Robot(6) = struct('color', 'magenta', 'x', 1, 'y', 0, 'dir', pi);
    Robot(7) = struct('color', 'magenta', 'x', 1, 'y', 1, 'dir', pi);
    Robot(8) = struct('color', 'magenta', 'x', 2.5, 'y', 0, 'dir', pi);
    
end

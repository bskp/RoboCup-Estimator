function Robot = rand_robot_init()
%DUMMY_INIT Initializes eight robots.
%
%   ROBOT = DUMMY_INIT() initializes eight structs which define robots on
%   the field. Every struct contains the position, the direction and the
%   color of the robot. Moreover the relative radius of a robot and their
%   maximum change of direction are defined as global variables.


%----------- Init of global variables -----------%

    global RobotParam dt;
    RobotParam.radius = 0.15; %[m]
    RobotParam.changeOfDir = 0.1 * 2*pi * dt; %[rad/step], expected value
    
    
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
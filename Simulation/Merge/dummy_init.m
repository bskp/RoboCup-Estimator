function Robot = dummy_init()
%DUMMY_INIT

    global RobotParam dt;
    RobotParam.radius = 0.15; %[m]
    RobotParam.velocity = 0.01 *dt; %[m/s]
    RobotParam.changeOfDir = pi./6 *dt; %[rad/s]

    Robot(1) = struct('color', 'blue', 'x', -1, 'y', -1, 'dir', 0);
    Robot(2) = struct('color', 'blue', 'x', -1, 'y', 0, 'dir', 0);
    Robot(3) = struct('color', 'blue', 'x', -1, 'y', 1, 'dir', 0);
    Robot(4) = struct('color', 'blue', 'x', -2.5, 'y', 0, 'dir', 0);
    Robot(5) = struct('color', 'magenta', 'x', 1, 'y', -1, 'dir', pi);
    Robot(6) = struct('color', 'magenta', 'x', 1, 'y', 0, 'dir', pi);
    Robot(7) = struct('color', 'magenta', 'x', 1, 'y', 1, 'dir', pi);
    Robot(8) = struct('color', 'magenta', 'x', 2.5, 'y', 0, 'dir', pi);

end


function RobotStep = dummy_step(Robot)
%DUMMY_STEP

    global RobotParam;

    omega = rand(1,8) - 0.5*ones(1,8);
    for i=1:8
        RobotStep(i).color = Robot(i).color;
        RobotStep(i).x = RobotParam.velocity * cos(Robot(i).dir) + Robot(i).x;
        RobotStep(i).y = RobotParam.velocity * sin(Robot(i).dir) + Robot(i).y;
        RobotStep(i).dir = omega(1,i)*RobotParam.changeOfDir + Robot(i).dir;
    end

end


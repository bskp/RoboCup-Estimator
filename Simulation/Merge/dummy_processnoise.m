function RobotStep = dummy_step(Robot)
%DUMMY_PROCESSNOISE

    global Noise;
    d = randn(8,3);
    
    for i=1:8
        RobotStep(i).color = Robot(i).color;
        RobotStep(i).x = Robot(i).x + d(i,1) * Noise.process.pos;
        RobotStep(i).y = Robot(i).y + d(i,2) * Noise.process.pos;
        RobotStep(i).dir =  Robot(i).dir + d(i,3) * Noise.process.dir;
    end
    
end


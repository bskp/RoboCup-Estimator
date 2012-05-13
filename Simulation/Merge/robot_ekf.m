function [robot_step P_step] = robot_ekf(robot_m,robot_e,m_values,e_values,d_omega,v,P)
%ROBOT_EKF Position-estimation for robots.
%
%   [ROBOT_STEP,P_STEP] =
%   ROBOT_EKF(ROBOT_M,ROBOT_E,M_VALUES,E_VALUES,D_OMEGA,V,P)
%   implements the extended Kalman filter cycle for the given motion model
%   after which the robots behave. The structs ROBOT_M and ROBOT_E refer to
%   the measured robot parameters and the previously estimated robot
%   parameters respectively. D_OMEGA (change of angular direction) and V
%   (velocity) are the inputs used to simulate the robot's motion and P is
%   the error covariance from the previous Kalman cycle. The new estimated
%   position of the robots and the new error covariance are the function's
%   outputs.

    global Noise RobotParam;
    
    
%--------- Init of covariance matrices and linearized matrices  ---------%

    Q = [Noise.process.pos*eye(2), [0;0]; [0 0 Noise.process.dir]];
    R = [Noise.measure.pos*eye(2), [0;0]; [0 0 Noise.measure.dir]];
    H = eye(3);
    V = eye(3);
    W = eye(3);
    x_apriori = [0;0;0];
    K = zeros(3,3,8);
    P_step = zeros(3,3,8);
    
    
%-------- Enable usage of adaptive measurement covariance matrix  --------%    

%     s = size(m_values);
%     d_R = ones(1,8);
%     
%     if(s(2)>29)
%         [d_R, d_theta] = i_measurement(m_values, e_values);
%     end
%     d_theta = zeros(1,8);
    

%----------- Kalman cycle  -----------%

    for i=1:8
       
       % Linearization of system dynamics
       A = [1 0 -v(i)*sin(robot_e(i).dir);0 1 v(i)*cos(robot_e(i).dir);0 0 1]; 
       
       % Time update (predict)   
       x_apriori(1) = robot_e(i).x+cos(robot_e(i).dir)*v(i);
       x_apriori(2) = robot_e(i).y+sin(robot_e(i).dir)*v(i);
       x_apriori(3) = robot_e(i).dir+d_omega(i);
       P_step(:,:,i) = A*P(:,:,i)*A'+W*Q*W';
       
       % Measurement update (correct)
       if isnan(robot_m(i).x * robot_m(i).y * robot_m(i).dir)
           estimates = x_apriori;   % Measurement drop
       else
           K(:,:,i) =  (P_step(:,:,i)*H')/(H*P_step(:,:,i)*H'+V*R*V');
           estimates = x_apriori+K(:,:,i)*([robot_m(i).x; robot_m(i).y; robot_m(i).dir] - x_apriori);
           P_step(:,:,i) = (eye(3)-K(:,:,i)*H)*P_step(:,:,i);
       end
       
       % Parameter assignment
       robot_step(i).color = robot_e(i).color;
       robot_step(i).x = estimates(1);
       robot_step(i).y = estimates(2);
       robot_step(i).dir = estimates(3);
    end
    
    
%----------- Collision detection  -----------%
%     
%     for i = 1:8        
%         % Robot collision
%         for j = (i+1):8
%             d = sqrt( (robot_e(i).x-robot_e(j).x)^2+(robot_e(i).y-robot_e(j).y)^2);
%             if (d < 2*RobotParam.radius)
%                 d = robot_e(i).dir;
%                 robot_step(i).dir = robot_e(j).dir;
%                 robot_step(j).dir = d;
%                 
%                 % Step towards new direction
%                 robot_step(i).x = RobotParam.velocity * 2 * cos(robot_step(i).dir) + robot_step(i).x;
%                 robot_step(i).y = RobotParam.velocity * 2 * sin(robot_step(i).dir) + robot_step(i).y;
%                 robot_step(j).x = RobotParam.velocity * 2 * cos(robot_step(j).dir) + robot_step(j).x;
%                 robot_step(j).y = RobotParam.velocity * 2 * sin(robot_step(j).dir) + robot_step(j).y;
%             end
%         end
%         
%         % Boundaries collision
%         if abs(robot_step(i).x) > 3 - RobotParam.radius
%             robot_step(i).dir = pi - robot_e(i).dir;
%             robot_step(i).x = RobotParam.velocity * cos(robot_step(i).dir) + robot_e(i).x;
%             robot_step(i).y = RobotParam.velocity * sin(robot_step(i).dir) + robot_e(i).y;
%         end
%         
%         if abs(robot_step(i).y) > 2 - RobotParam.radius
%             robot_step(i).dir = -robot_e(i).dir;
%             robot_step(i).x = RobotParam.velocity * cos(robot_step(i).dir) + robot_e(i).x;
%             robot_step(i).y = RobotParam.velocity * sin(robot_step(i).dir) + robot_e(i).y;
%         end
%     end
     
end


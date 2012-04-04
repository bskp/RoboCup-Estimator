function [robot_step P_step] = ext_kalman_filter(robot_m,robot_e,m_values,e_values,d_omega,P)
%EXT_KALMAN_FILTER
    global Noise RobotParam;
    
%init
    W = eye(3);
    Q = [Noise.process.pos*eye(2), [0;0]; [0 0 Noise.process.dir] ];
    H = [1,0,0;0,1,0;0,0,1];
    V = eye(3);
    x_apriori = [0;0;0];
    %A = eye(3);
    K = zeros(3,3,8);
    P_step = zeros(3,3,8);
    
   
    s = size(m_values);
    d_R = ones(1,8);
    
    if(s(2)>29)
        %[d_R, d_theta] = i_measurement(m_values, e_values);
    end
   d_theta = zeros(1,8);
    
% Algorithm taken from kalman_intro.pdf
% Time update (predict)
    for i=1:8
       A = [1 0 -RobotParam.velocity*sin(robot_e(i).dir);
           0 1 RobotParam.velocity*cos(robot_e(i).dir);
           0 0 1]; 
       R = [[eye(2)*Noise.measure.pos*d_R(i) [0;0]];[0 0 Noise.measure.dir]];
       x_apriori(1) = robot_e(i).x+cos(robot_e(i).dir)*RobotParam.velocity;
       x_apriori(2) = robot_e(i).y+sin(robot_e(i).dir)*RobotParam.velocity;
       x_apriori(3) = robot_e(i).dir+d_omega(i)+d_theta(i);
       P_step(:,:,i) = A*P(:,:,i)*A'+W*Q*W';
       

% Measurement update (correct)
       K(:,:,i) =  (P_step(:,:,i)*H')/(H*P_step(:,:,i)*H'+V*R*V');
       estimates = x_apriori+K(:,:,i)*([robot_m(i).x; robot_m(i).y; robot_m(i).dir]-[x_apriori(1); x_apriori(2); x_apriori(3)]);
       robot_step(i).color = robot_e(i).color;
       robot_step(i).x = estimates(1);
       robot_step(i).y = estimates(2);
       robot_step(i).dir = estimates(3);
       P_step(:,:,i) = (eye(3)-K(:,:,i)*H)*P_step(:,:,i);
    end
    
    
    % COLLISION DETECTION
    
    for i = 1:8        
        % Robot collision
        for j = (i+1):8
            d = sqrt( (robot_e(i).x-robot_e(j).x)^2+(robot_e(i).y-robot_e(j).y)^2);
            if (d < 2*RobotParam.radius)
                d = robot_e(i).dir;
                robot_step(i).dir = robot_e(j).dir;
                robot_step(j).dir = d;
                
                % Step towards new direction
                robot_step(i).x = RobotParam.velocity * 2 * cos(robot_step(i).dir) + robot_step(i).x;
                robot_step(i).y = RobotParam.velocity * 2 * sin(robot_step(i).dir) + robot_step(i).y;
                robot_step(j).x = RobotParam.velocity * 2 * cos(robot_step(j).dir) + robot_step(j).x;
                robot_step(j).y = RobotParam.velocity * 2 * sin(robot_step(j).dir) + robot_step(j).y;
            end
        end
        
        % Boundaries collision
        if abs(robot_step(i).x) > 3 - RobotParam.radius
            robot_step(i).dir = pi - robot_e(i).dir;
            robot_step(i).x = RobotParam.velocity * cos(robot_step(i).dir) + robot_e(i).x;
            robot_step(i).y = RobotParam.velocity * sin(robot_step(i).dir) + robot_e(i).y;
        end
        
        if abs(robot_step(i).y) > 2 - RobotParam.radius
            robot_step(i).dir = -robot_e(i).dir;
            robot_step(i).x = RobotParam.velocity * cos(robot_step(i).dir) + robot_e(i).x;
            robot_step(i).y = RobotParam.velocity * sin(robot_step(i).dir) + robot_e(i).y;
        end
    end
    
    
end


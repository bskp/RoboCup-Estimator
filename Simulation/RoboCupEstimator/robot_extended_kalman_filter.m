function [robot_step P_step v_pink_step] = robot_extended_kalman_filter(robot_m,robot_e,m_values,e_values,d_omega,v,v_pink,P)
%ROBOT_EXTENDED_KALMAN_FILTER Position-estimation for the robots.
%
%   [ROBOT_STEP,P_STEP, V_PINK_STEP] =
%   ROBOT_EXTENDED_KALMAN_FILTER(ROBOT_M,ROBOT_E,M_VALUES,E_VALUES,D_OMEGA,V,V_PINK,P)
%   implements the extended Kalman filter cycle for the given motion model
%   after which the robots behave. The structs ROBOT_M and ROBOT_E refer to
%   the measured robot parameters and the previously estimated robot
%   parameters respectively. D_OMEGA (change of angular direction) and V
%   (velocity) are the inputs used to simulate the robot's motion and P is
%   the error covariance from the previous Kalman cycle. The new estimated
%   position of the robots and the new error covariance are the function's
%   outputs. Additional functionality is implemented for pink robots in
%   order to get their inputs and to track them properly.

    global Noise RobotParam;
    
    
%--------- Init of covariance matrices and linearized matrices  ---------%

    Q = [Noise.Process.pos.^2*eye(2), [0;0]; [0 0 Noise.Process.dir.^2]];
    H = eye(3);
    V = eye(3);
    W = eye(3);
    x_apriori = [0;0;0];
    K = zeros(3,3,8);
    P_step = zeros(3,3,8);
    
    
%--------- Approximation of the enemy's input  ---------%

    [d_omega_pink,v_pink_step] = input_approximation(robot_m,m_values,v_pink);

    
%-------- Enable usage of adaptive measurement covariance matrix  --------%    

     s = size(m_values);
     prob = ones(3,8);
     if(s(2)>2)
         [prob] = i_measurement(robot_m,m_values,e_values);
     end

%----------- Kalman cycle  -----------%

    for i=1:8
        
       % If no measurements are available, don't change R 
       if(isnan(prob(1,i)))
           prob(:,i) = ones(3,1);
       end
       
       % Original R
       R = zeros(3,3);
       R(1,1) = robot_m(i).sigma.^2;
       R(2,2) = robot_m(i).sigma.^2;
       R(3,3) = robot_m(i).sigma.^2;
       
       % Enable adaptive R only for pink robots
       if(i>4)
           R(1,1) = R(1,1)*pi*prob(1,i);
           R(2,2) = R(2,2)*pi*prob(2,i);
           R(3,3) = R(3,3)*pi*prob(3,i);
       end
       
       % Linearization of system dynamics
       A = [1 0 -v(i)*sin(robot_e(i).dir);0 1 v(i)*cos(robot_e(i).dir);0 0 1]; 
       
       if(i>4)
           v(i) = v_pink_step(i-4);
           d_omega(i) = d_omega_pink(i-4);
       end

       % Time update (predict)   
       x_apriori(1) = robot_e(i).x+cos(robot_e(i).dir)*v(i);
       x_apriori(2) = robot_e(i).y+sin(robot_e(i).dir)*v(i);
       x_apriori(3) = robot_e(i).dir+d_omega(i);
       P_step(:,:,i) = A*P(:,:,i)*A'+W*Q*W';
       
       % Measurement update (correct)
       if isnan(robot_m(i).x * robot_m(i).y * robot_m(i).dir)
           estimates = x_apriori;   % Measurement drop
       else
           z = [robot_m(i).x; robot_m(i).y; robot_m(i).dir];
           K(:,:,i) =  (P_step(:,:,i)*H')/(H*P_step(:,:,i)*H'+V*R*V');
           estimates = x_apriori+K(:,:,i)*(z - x_apriori);
           P_step(:,:,i) = (eye(3)-K(:,:,i)*H)*P_step(:,:,i);
       end
       
       % Parameter assignment
       robot_step(i).color = robot_e(i).color;
       robot_step(i).x = estimates(1);
       robot_step(i).y = estimates(2);
       robot_step(i).dir = estimates(3);
    end
    
end
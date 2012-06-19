function [robotStep Pstep vPinkStep Knorm] = ...
    robot_extended_kalman_filter(robotMeasure,robotEstimate,mValues,eValues,dOmega,v,vPink,P)
%ROBOT_EXTENDED_KALMAN_FILTER Position-estimation for the robots.
%
%   [ROBOTSTEP,PSTEP, VPINKSTEP] =
%   ROBOT_EXTENDED_KALMAN_FILTER(ROBOTMEASURE,ROBOTESTIMATE,MVALUES,EVALUES,DOMEGA,V,VPINK,P)
%   implements the extended Kalman filter cycle for the given motion model
%   after which the robots behave. The structs ROBOTMEASURE and
%   ROBOTESTIMATE refer to the measured robot parameters and the previously
%   estimated robot parameters respectively. DOMEGA (change of angular
%   direction) and V (velocity) are the inputs used to simulate the robot's
%   motion and P is the error covariance from the previous Kalman cycle.
%   The new estimated position of the robots and the new error covariance
%   are the function's outputs. Additional functionality is implemented for
%   pink robots in order to get their inputs and to track them properly.

    global Noise RobotParam;
    
    
%--------- Init of covariance matrices and linearized matrices  ---------%

    Q = [Noise.Process.pos.^2*eye(2), [0;0]; [0 0 Noise.Process.dir.^2]];
    H = eye(3);
    V = eye(3);
    W = eye(3);
    xApriori = [0;0;0];
    K = zeros(3,3,8);
    Pstep = zeros(3,3,8);
    
    
%--------- Approximation of the enemy's input  ---------%

    [dOmegaPink,vPinkStep] = input_approximation(robotMeasure,mValues,vPink);

    
%-------- Enable usage of adaptive measurement covariance matrix  --------%    

     s = size(mValues);
     prob = ones(3,8);
     if(s(2)>2)
         [prob] = i_measurement(robotMeasure,mValues,eValues);
     end

%----------- Kalman cycle  -----------%

    for i=1:8
        
       % If no measurements are available, don't change R 
       if(isnan(prob(1,i)))
           prob(:,i) = ones(3,1);
       end
       
       % Original R
       R = zeros(3,3);
       R(1,1) = robotMeasure(i).sigma.^2;
       R(2,2) = robotMeasure(i).sigma.^2;
       R(3,3) = robotMeasure(i).sigma.^2;
       
       % Enable adaptive R only for pink robots
       if(i>4)
           R(1,1) = R(1,1)*pi*prob(1,i);
           R(2,2) = R(2,2)*pi*prob(2,i);
           R(3,3) = R(3,3)*pi*prob(3,i);
       end
       
       % Linearization of system dynamics
       A = [1 0 -v(i)*sin(robotEstimate(i).dir);0 1 v(i) * ...
           cos(robotEstimate(i).dir);0 0 1]; 
       
       if(i>4)
           v(i) = vPinkStep(i-4);
           dOmega(i) = dOmegaPink(i-4);
           % applying estimated control values
       end

       % Time update (predict)   
       xApriori(1) = robotEstimate(i).x+cos(robotEstimate(i).dir)*v(i);
       xApriori(2) = robotEstimate(i).y+sin(robotEstimate(i).dir)*v(i);
       xApriori(3) = robotEstimate(i).dir+dOmega(i);
       Pstep(:,:,i) = A*P(:,:,i)*A'+W*Q*W';
       
       % Measurement update (correct)
       if isnan(robotMeasure(i).x * robotMeasure(i).y * robotMeasure(i).dir)
           estimates = xApriori;   % Measurement drop
           Knorm(i) = NaN;
       else
           z = [robotMeasure(i).x; robotMeasure(i).y; robotMeasure(i).dir];
           K(:,:,i) =  (Pstep(:,:,i)*H')/(H*Pstep(:,:,i)*H'+V*R*V');
           Knorm(i) = norm(K(:,:,i));
           estimates = xApriori+K(:,:,i)*(z - xApriori);
           Pstep(:,:,i) = (eye(3)-K(:,:,i)*H)*Pstep(:,:,i);
       end
       
       % Parameter assignment
       robotStep(i).color = robotEstimate(i).color;
       robotStep(i).x = estimates(1);
       robotStep(i).y = estimates(2);
       robotStep(i).dir = estimates(3);
    end
    
end
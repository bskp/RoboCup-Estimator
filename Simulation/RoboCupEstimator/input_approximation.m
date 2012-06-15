function [d_omega_step,v_step] = input_approximation(robot_m,m_values,v)
%INPUT_APPROXIMATION Approximates the input of the pink robots.
%
%   [D_OMEGA_STEP,V_STEP] = INPUT_APPROXIMATION(ROBOT_M,M_VALUES,V) takes
%   the current (ROBOT_M) and former (M_VALUES) measurement values of all
%   robots and computes the estimated input variables for the change of the
%   angular position, D_OMEGA_STEP and the velocity, V_STEP. This is only
%   necessary for the pink robots, data of all blue robots is not needed.
%   Furthermore the former computed velocity V is needed, to get the mean
%   value of the velocity over several time steps. This improves
%   performance and only works by assuming that large changes in velocity
%   are not possible for robots.

    global dt RobotParam
    
%--------- Init of performance variables and vectors  ---------%

    s = size(m_values);
    window_size = 5;            % Amount of time steps over which we take
                                % the mean of the velocity.
    d_omega_step = zeros(4,1);
    v_step = zeros(4,1);
    
    
%--------- Input approximation for pink robots  ---------%

    for i=5:8
        
        if(s < 2 | isnan(robot_m(i).x*robot_m(i).y*robot_m(i).dir) | isnan(m_values(1,1,i)*m_values(2,1,i)*m_values(3,1,i)))
            d_omega_step(i-4) = 0;
            v_step(i-4) = RobotParam.velocity;
        else
            d_omega_step(i-4) = robot_m(i).dir - m_values(3,1,i);
            v_new = dt*sqrt((robot_m(i).x-m_values(1,1,i)).^2+(robot_m(i).y-m_values(2,1,i)).^2);
            v_step(i-4) = (v(i-4)*(window_size-1)+v_new)/window_size;
        end
        
    end
    
end


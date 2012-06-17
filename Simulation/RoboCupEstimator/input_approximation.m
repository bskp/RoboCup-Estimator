function [dOmegaStep,vStep] = input_approximation(RobotMeasure,mValues,v)
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

    s = size(mValues);
    windowSize = 5;            % Amount of time steps over which we take
                                % the mean of the velocity.
    dOmegaStep = zeros(4,1);
    vStep = zeros(4,1);
    
    
%--------- Input approximation for pink robots  ---------%

    for i=5:8
        
        if(s < 2 | isnan(RobotMeasure(i).x*RobotMeasure(i).y*RobotMeasure(i).dir) ...
                | isnan(mValues(1,1,i)*mValues(2,1,i)*mValues(3,1,i)))
            dOmegaStep(i-4) = 0;
            vStep(i-4) = RobotParam.velocity;
        else
            dOmegaStep(i-4) = RobotMeasure(i).dir - mValues(3,1,i);
            vNew = dt*sqrt((RobotMeasure(i).x - mValues(1,1,i)).^2 + ...
                (RobotMeasure(i).y - mValues(2,1,i)).^2);
            vStep(i-4) = (v(i-4)*(windowSize-1)+vNew)/windowSize;
        end
        
    end
    
end


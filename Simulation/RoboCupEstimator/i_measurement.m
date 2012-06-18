function [prob] = i_measurement(RobotMeasure,mValues,eValues)
%I_MEASUREMENT Dynamic adaption of covariance matrix.
%
%   [PROB] = I_MEASUREMENT(ROBOTMEASURE,MVALUES,EVALUES) uses the former
%   measurements from the robots MVALUES and the former estimation from
%   the robots EVALUES in order to compute correction parameters for the
%   covariance matrix R, used in the extended Kalman filtering algorithm.
%   We use a probabilistic model.

    global Noise


%----------- Initialization of angle vector and history size  -----------%

    probX = zeros(1,8);
    probY = zeros(1,8);
    probDir = zeros(1,8);


%----------- Initialization of history for every robot  -----------%

    for i = 1:8
    
% Correction of the position
        
        % Probabilities that the absolute differences of position and 
        % direction between estimates and measurements is bigger than the
        % actual differences.
        xAbs = abs(eValues(1,1,i) - mValues(1,1,i));
        yAbs = abs(eValues(2,1,i) - mValues(2,1,i));
        dirAbs = abs(eValues(3,1,i) - mValues(3,1,i));
        probX(i) = erfc(xAbs/(sqrt(RobotMeasure(i).sigma)));
        probY(i) = erfc(yAbs/(sqrt(RobotMeasure(i).sigma)));
        probDir(i) = erfc(dirAbs/(sqrt(RobotMeasure(i).sigma*2*pi)));
        
        prob = [probX; probY; probDir]; 
    end    
end


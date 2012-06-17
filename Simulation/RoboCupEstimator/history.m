function [mValues eValues] = history(mOld, eOld, RobotMeasure, RobotEstimate)
%HISTORY History of former measurements and estimations of the robots.
%
%   [M_VALUES,E_VALUES] = HISTORY(M_OLD,E_OLD,ROBOT_M,ROBOT_E) records the
%   last few measurements and estimations of every robot in order to use
%   the data for later calculations. The old values M_OLD and E_OLD get
%   updated by the latest parameters from ROBOT_M and ROBOT_E and the new
%   values M_VALUES and E_VALUES appear as output. Note that also dropped
%   measuremetns are recorded and will appear in the history as "NaN".


%----------- Compute current history size  -----------%

    s = size(mOld);
    numOfMeasurements = s(2);
    BUFFER_SIZE = 30;   % Length of history


%----------- Updating the history for every robot -----------%

% If history has not yet BUFFER_SIZE elements
    if(numOfMeasurements < BUFFER_SIZE)
        mValues = zeros(3, numOfMeasurements+1, 8);
        eValues = zeros(3, numOfMeasurements+1, 8);
    
        for i = 1:8
            mValues(:,:,i) = [[RobotMeasure(i).x; RobotMeasure(i).y; ...
                RobotMeasure(i).dir], mOld(:,:,i)];
            eValues(:,:,i) = [[RobotEstimate(i).x; RobotEstimate(i).y; ...
                RobotEstimate(i).dir], eOld(:,:,i)];
        end 
    
% If history has already BUFFER_SIZE elements
    else
        mValues = zeros(3, BUFFER_SIZE, 8);
        eValues = zeros(3, BUFFER_SIZE, 8);
    
        for i = 1:8
            mValues(:,:,i) = [[RobotMeasure(i).x; RobotMeasure(i).y; ...
                RobotMeasure(i).dir], mOld(:,1:end-1,i)];
            eValues(:,:,i) = [[RobotEstimate(i).x; RobotEstimate(i).y; ...
                RobotEstimate(i).dir], eOld(:,1:end-1,i)];
        end 
    end
end
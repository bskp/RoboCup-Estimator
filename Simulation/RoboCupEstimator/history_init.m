function [mValues, eValues] = history_init(RobotMeasure, RobotEstimate)
%HISTORY_INIT Initialization of new history.
%
%   [M_VALUES,E_VALUES] = HISTORY_INIT(ROBOT_M,ROBOT_E) creates the two new
%   recordings M_VALUES and E_VALUES by adding all relevant parameters from
%   ROBOT_M and ROBOT_E.


%----------- Initialization of history for every robot  -----------%

    for i = 1:8
        mValues(:,:,i) = [RobotMeasure(i).x; RobotMeasure(i).y; ...
            RobotMeasure(i).dir];
        eValues(:,:,i) = [RobotEstimate(i).x; RobotEstimate(i).y; ...
            RobotEstimate(i).dir]; 
    end
end
function [mValues, eValues] = history_init(RobotMeasure, RobotEstimate)
%HISTORY_INIT Initialization of new history.
%
%   [MVALUES,EVALUES] = HISTORY_INIT(ROBOTMEASURE,ROBOTESTIMATE) creates
%   the two new recordings MVALUES and EVALUES by adding all relevant
%   parameters from ROBOTMEASURE and ROBOTESTIMATE.


%----------- Initialization of history for every robot  -----------%

    for i = 1:8
        mValues(:,:,i) = [RobotMeasure(i).x; RobotMeasure(i).y; ...
            RobotMeasure(i).dir];
        eValues(:,:,i) = [RobotEstimate(i).x; RobotEstimate(i).y; ...
            RobotEstimate(i).dir]; 
    end
end
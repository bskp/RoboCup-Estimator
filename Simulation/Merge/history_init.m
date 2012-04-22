function [m_values, e_values] = history_init(Robot_m, Robot_e)
%HISTORY_INIT Initialization of new history.
%
%   [M_VALUES,E_VALUES] = HISTORY_INIT(ROBOT_M,ROBOT_E) creates the two new
%   recordings M_VALUES and E_VALUES by adding all relevant parameters from
%   ROBOT_M and ROBOT_E.


%----------- Initialization of history for every robot  -----------%

    for i = 1:8
        m_values(:,:,i) = [Robot_m(i).x; Robot_m(i).y; Robot_m(i).dir];
        e_values(:,:,i) = [Robot_e(i).x; Robot_e(i).y; Robot_e(i).dir]; 
    end
end


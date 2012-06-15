function [m_values e_values] = history(m_old,e_old, Robot_m, Robot_e)
%HISTORY History of former measurements and estimations of the robots.
%
%   [M_VALUES,E_VALUES] = HISTORY(M_OLD,E_OLD,ROBOT_M,ROBOT_E) records the
%   last few measurements and estimations of every robot in order to use
%   the data for later calculations. The old values M_OLD and E_OLD get
%   updated by the latest parameters from ROBOT_M and ROBOT_E and the new
%   values M_VALUES and E_VALUES appear as output. Note that also dropped
%   measuremetns are recorded and will appear in the history as "NaN".


%----------- Compute current history size  -----------%

    s = size(m_old);
    num_of_measurements = s(2);
    BUFFER_SIZE = 30;   % Length of history


%----------- Updating the history for every robot -----------%

% If history has not yet BUFFER_SIZE elements
    if(num_of_measurements < BUFFER_SIZE)
        m_values = zeros(3,num_of_measurements+1,8);
        e_values = zeros(3,num_of_measurements+1,8);
    
        for i = 1:8
            m_values(:,:,i) = [[Robot_m(i).x; Robot_m(i).y; Robot_m(i).dir], m_old(:,:,i)];
            e_values(:,:,i) = [[Robot_e(i).x; Robot_e(i).y; Robot_e(i).dir], e_old(:,:,i)];
        end 
    
% If history has already BUFFER_SIZE elements
    else
        m_values = zeros(3,BUFFER_SIZE,8);
        e_values = zeros(3,BUFFER_SIZE,8);
    
        for i = 1:8
            m_values(:,:,i) = [[Robot_m(i).x; Robot_m(i).y; Robot_m(i).dir], m_old(:,1:end-1,i)];
            e_values(:,:,i) = [[Robot_e(i).x; Robot_e(i).y; Robot_e(i).dir], e_old(:,1:end-1,i)];
        end 
    end
end


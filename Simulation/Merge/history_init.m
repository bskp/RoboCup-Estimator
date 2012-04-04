function [m_values, e_values] = history_init(Robot_m, Robot_e)
%HISTORY_INIT Summary of this function goes here
%   Detailed explanation goes here

for i = 1:8
m_values(:,:,i) = [Robot_m(i).x; Robot_m(i).y; Robot_m(i).dir];
e_values(:,:,i) = [Robot_e(i).x; Robot_e(i).y; Robot_e(i).dir]; 
end

end


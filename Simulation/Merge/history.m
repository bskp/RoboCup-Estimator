function [m_values e_values] = history(m_old,e_old, Robot_m, Robot_e)
%HISTORY Summary of this function goes here
%   Detailed explanation goes here

s = size(m_old);
num_of_measurements = s(2);
buffer_size = 30;

for i = 1:8

end

if(num_of_measurements < buffer_size)
    m_values = zeros(3,num_of_measurements+1,8);
    e_values = zeros(3,num_of_measurements+1,8);
    for i = 1:8
        m_values(:,:,i) = [[Robot_m(i).x; Robot_m(i).y; Robot_m(i).dir], m_old(:,:,i)];
        e_values(:,:,i) = [[Robot_e(i).x; Robot_e(i).y; Robot_e(i).dir], e_old(:,:,i)]; 
    end 
else
    m_values = zeros(3,buffer_size,8);
    e_values = zeros(3,buffer_size,8);
    for i = 1:8

        m_values(:,:,i) = [[Robot_m(i).x; Robot_m(i).y; Robot_m(i).dir], m_old(:,1:end-1,i)];
        e_values(:,:,i) = [[Robot_e(i).x; Robot_e(i).y; Robot_e(i).dir], e_old(:,1:end-1,i)]; 
    end 
end

end


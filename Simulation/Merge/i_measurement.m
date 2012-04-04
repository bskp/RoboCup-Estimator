function [d_R d_theta] = i_measurement(m_values,e_values)
%I_MEASUREMENT Summary of this function goes here
%   Detailed explanation goes here

global Noise

s = size(m_values);
num_of_measurements = s(2);
d_theta = zeros(8,1);
for i = 1:8
% Correction of the angular value
    
    A = [e_values(1,:,i)',ones(num_of_measurements,1)];
    b = e_values(2,:,i)';
    m = A\b;
    theta = atan(m(1));
    if(e_values(1,1,i) < e_values(1,2,i))
        theta = theta + pi;
    end
    d_angle = mod(theta - e_values(3,1,i),2*pi);
    d_theta(i) = d_angle.*exp(abs(d_angle)/pi-3);
    if(abs(d_angle) < pi/9)
        d_theta(i) = 0;
    end

% Correction of the position

    delta = abs(m_values(1:2,:,i)-e_values(1:2,:,i));
    mean = sum(sum(delta))/(2*num_of_measurements*0.47693627*Noise.measure.pos*2);
    % We use the fact, that E[delta] = 0.47693627
    d_R(i) = 1/exp((mean-1)*30);
    if(mean < 1)
        d_R(i) = 1;
    end
    
end
end


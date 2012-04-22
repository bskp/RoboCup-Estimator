function [d_R d_theta] = i_measurement(m_values,e_values)
%I_MEASUREMENT Dynamic adaption of covariance matrix and angular direction.
%
%   [D_R,D_THETA] = I_MEASUREMENT(M_VALUES,EVALUES) uses the former
%   measurements from the robots M_VALUES and the former estimation from
%   the robots E_VALUES in order to compute correction parameters for the
%   covariance matrix R, used in the extended Kalman filtering algorithm,
%   and for the angular position. The parameters are stored in the
%   variables D_R and D_THETA respectively.

    global Noise


%----------- Initialization of angle vector and history size  -----------%

    s = size(m_values);
    num_of_measurements = s(2);
    d_theta = zeros(8,1);


%----------- Initialization of history for every robot  -----------%

    for i = 1:8
    
% Correction of the angular value    
        A = [e_values(1,:,i)',ones(num_of_measurements,1)];
        b = e_values(2,:,i)';
        m = A\b;                % Computing the robot's direction by using
        theta = atan(m(1));     % the least squares method.
    
        if(e_values(1,1,i) < e_values(1,2,i))   % Calculating correct angle
        theta = theta + pi;
        end
        d_angle = mod(theta - e_values(3,1,i),2*pi);
    
        d_theta(i) = d_angle.*exp(abs(d_angle)/pi-3);   % Trust function
        if(abs(d_angle) < pi/9)         % Disable correction mechanism for
            d_theta(i) = 0;             % small pertubations (<20°)
        end

% Correction of the position
        delta = abs(m_values(1:2,:,i)-e_values(1:2,:,i));   % Mean of the position
        mean = sum(sum(delta))/(2*num_of_measurements*0.47693627*Noise.measure.pos*2);
        % We use the fact, that E[delta] = 0.47693627
    
        d_R(i) = 1/exp((mean-1)*30);    % Trust function
        if(mean < 1)                    % Disable correction mechanism for
            d_R(i) = 1;                 % small pertubations
        end
    end
end


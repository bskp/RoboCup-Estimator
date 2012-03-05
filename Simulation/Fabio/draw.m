function A = draw(struct, A, b)
%DRAW   Draw takes the current field situation and an object, such as a
%       ball or a robot, computes their position on the field an finally
%       adds them to the field. The parameter b is used as an offset, since 
%       the robots are localized in the playing area.

if(strcmp(struct.color, 'blue'))        % Choosing the correct color
    color = 3;
elseif(strcmp(struct.color, 'pink'))
    color = 4;
else
    color = 5;
end

size = 9;                               % Size of the dot

dot = ones(size,size)*color;            % Creating the dot
x = round(struct.x);                    % Reading the x position
y = round(struct.y);                    % Reading the y position
lower = floor((size-1)/2);              % Lower border of the dot
upper = ceil((size-1)/2);               % Upper border of the dot

% Adding the robot to the field
A(x-lower+b:x+upper+b,y-lower+b:y+upper+b) = dot;

end


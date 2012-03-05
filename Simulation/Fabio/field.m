function A = field(player_array, ball, width, length, upm)
%FIELD   The function field has four parameters, namely the array with all
%        players in it and the ball-object and the dimensions of the field.
%        Using the positions and angles, field computes the matrix A with
%        the current field situation. Displaying this matrix with the
%        function image(A), leads to a  graphical illustration of the
%        simulation.

%% ----------------------------------------------------------------------
%                            Setting the scene
%  ----------------------------------------------------------------------

b = round(0.7*upm);                                % Width of the area out-
                                                   % side the playing area
B = ones(width+9, length+9);                       % Borders
A = ones(width+b*2, length+b*2)*6;                 % Whole Area
A(b-4:width+b+4,b-4:length+b+4) = B;               % Create borders
A(b+1:width+b,b+1:length+b) = ones(width,length)*6;% Create playing area

%% ----------------------------------------------------------------------
%                       Computation of the matrix A
%  ----------------------------------------------------------------------

[m,n] = size(player_array);
for i=1:n                           % Adding players
    A = draw(player_array(i),A,b);
end
A = draw(ball,A,b);                 % Adding the ball



end


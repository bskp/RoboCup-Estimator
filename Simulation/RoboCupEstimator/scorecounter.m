%    ___         __        _____          
%   / _ \ ___   / /  ___  / ___/__ __ ___ 
%  / , _// _ \ / _ \/ _ \/ /__ / // // _ \
% /_/|_| \___//_.__/\___/\___/ \_,_// .__/ Score Counter
%                                  /_/    

global Field;

if abs(BallStep.y) < Field.goalHeight./2
   global Score;
   if BallStep.x > 0
       Score.blue = Score.blue + 1;
   else
       Score.pink = Score.pink + 1;
   end
end
 
% Generates random player starting positions

dummy.speed = 0.1; % m/step
dummy.deviation = 10; % degrees/step
dummy.diameter = 0.3; % m

for i = 1:10;
    player(i).team = mod(i, 2);
    player(i).x = rand * field.width;
    player(i).y = rand * field.height;
    player(i).dir = rand * 2*pi;
end
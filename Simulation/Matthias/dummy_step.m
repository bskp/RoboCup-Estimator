% generates random player movements according to unicycle model

for i = 1:num_players;
    player(i).dir = player(i).dir + rand * dummy.deviation;
    player(i).x = player(i).x + dummy.speed*cos( player(i).dir );
    player(i).y = player(i).y + dummy.speed*sin( player(i).dir );
end
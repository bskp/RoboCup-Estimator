x = sort(rand(1,6));
y = sort(rand(1,6));

[sep,r,m1,b1,m2,b2] = reg_sep(x,y,true);


deg_1 = atan(m1)*180/pi
deg_2 = atan(m2)*180/pi

deg_d = deg_2-deg_1
sep
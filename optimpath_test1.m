clc
clear all
close all

a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0;
d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0.065*10;

DH = [-pi/2, a1, d1, 0;
          0, a2, d2, 0;
      -pi/2, a3, d3, 0;
       pi/2,  0, d4, 0;
      -pi/2,  0,  0, 0;
          0,  0, d6, 0];

th_path = pi/2 * rand(8, 6, 100);
realindex = ones(8, 100);
thdot_path = rand(8, 6, 100);
J_path = 2*rand(6, 6, 100, 8);
vl = 0.75; %Cte (m/s)
ac = 0.5*0.001; %Cte (m)
ts = ac/vl; %Cte (s)

path = optimpath(th_path, realindex, thdot_path, J_path, ts)
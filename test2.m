clear all
close all
clc


a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0.25*10;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0;

DH = [-pi/2, a1, d1, 0;
          0, a2, d2, 0;
      -pi/2, a3, d3, 0;
       pi/2,  0, d4, 0;
      -pi/2,  0,  0, 0;
          0,  0, d6, 0];
%     DH = [-pi/2, 0.07, 0.352, 30*pi/180;
%               0, 0.36,     0, -30*pi/180;
%           -pi/2,    0,     0, 20*pi/180;
%           +pi/2,    0,  0.38, 60*pi/180;
%           -pi/2,    0,     0, -45*pi/180;
%               0,    0,     0, -30*pi/180];
%     DH = [-pi/2, 1, 1.5, 30*pi/180;
%               0, 2, 2.5, -30*pi/180;
%           -pi/2, 3, -1.5, 20*pi/180;
%           +pi/2, 0, 0.5, 60*pi/180;
%           -pi/2, 0, 0, -45*pi/180;
%               0, 0, 0, -30*pi/180];
%     DH = [-pi/2,      0.1,       0, 30*pi/180;
%               0,   0.4318, 0.14909, -30*pi/180;
%           -pi/2, -0.02032,       0, 20*pi/180;
%           +pi/2,        0, 0.43307, 60*pi/180;
%           -pi/2,        0,       0, -45*pi/180;
%               0,        0, 0.05625, -30*pi/180];
    alpha1 = DH(1, 1);
    alpha2 = DH(2, 1);
    alpha3 = DH(3, 1);
    alpha4 = DH(4, 1);
    alpha5 = DH(5, 1);
    alpha6 = DH(6, 1);
    a1 = DH(1, 2);
    a2 = DH(2, 2);
    a3 = DH(3, 2);
    a4 = DH(4, 2);
    a5 = DH(5, 2);
    a6 = DH(6, 2);
    d1 = DH(1, 3);
    d2 = DH(2, 3);
    d3 = DH(3, 3);
    d4 = DH(4, 3);
    d5 = DH(5, 3);
    d6 = DH(6, 3);
    figure
    title('Workspace')
    axis([-8 8 -8 8 -8 8])
    hold on
    for k = linspace(-8, 8, 5)
    % importing goal position and orientation
    
    x1 = linspace(-8,8,41);
    y1 = linspace(-8,8,41);
    z1 = k+d1;
    %z1 = linspace(-5+d1,5+d1,31);
    n=41;
    %figure
    %axis([-7 7 -7 7 -7 7])
    %hold on
    for i=1:n
        for j=1:n
            
                x = x1(i);
                y = y1(j);
                z = z1 - d1;
                r = x^2 + y^2 + z^2;
                a = a1^4*sin(alpha1)^2 + a2^4*sin(alpha1)^2 + a3^4*sin(alpha1)^2 + d2^4*sin(alpha1)^2 + d3^4*sin(alpha1)^2 + d4^4*sin(alpha1)^2 + r^2*sin(alpha1)^2 + 4*a1^2*z^2 + 4*a1^2*d2^2*cos(alpha1)^2 - 2*a1^2*a2^2*sin(alpha1)^2 - 2*a1^2*a3^2*sin(alpha1)^2 + 6*a2^2*a3^2*sin(alpha1)^2 + 2*a1^2*d2^2*sin(alpha1)^2 + 2*a1^2*d3^2*sin(alpha1)^2 + 2*a2^2*d2^2*sin(alpha1)^2 + 2*a1^2*d4^2*sin(alpha1)^2 + 2*a2^2*d3^2*sin(alpha1)^2 + 2*a3^2*d2^2*sin(alpha1)^2 + 2*a2^2*d4^2*sin(alpha1)^2 + 2*a3^2*d3^2*sin(alpha1)^2 + 2*a3^2*d4^2*sin(alpha1)^2 + 2*d2^2*d3^2*sin(alpha1)^2 + 2*d2^2*d4^2*sin(alpha1)^2 + 2*d3^2*d4^2*sin(alpha1)^2 - 4*a2*a3^3*sin(alpha1)^2 - 4*a2^3*a3*sin(alpha1)^2 - 2*a1^2*r*sin(alpha1)^2 - 2*a2^2*r*sin(alpha1)^2 - 2*a3^2*r*sin(alpha1)^2 - 2*d2^2*r*sin(alpha1)^2 - 2*d3^2*r*sin(alpha1)^2 - 2*d4^2*r*sin(alpha1)^2 + 4*a1^2*a2*a3*sin(alpha1)^2 - 4*a2*a3*d2^2*sin(alpha1)^2 - 4*a2*a3*d3^2*sin(alpha1)^2 - 4*a2*a3*d4^2*sin(alpha1)^2 + 4*a1^2*d3^2*cos(alpha1)^2*cos(alpha2)^2 + 4*d2^2*d3^2*cos(alpha2)^2*sin(alpha1)^2 + 4*d3^2*d4^2*cos(alpha3)^2*sin(alpha1)^2 - 4*a1^2*d3^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2*d3^3*cos(alpha2)*sin(alpha1)^2 + 4*d2^3*d3*cos(alpha2)*sin(alpha1)^2 + 4*d3*d4^3*cos(alpha3)*sin(alpha1)^2 + 4*d3^3*d4*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d2*z*cos(alpha1) + 4*a2*a3*r*sin(alpha1)^2 + 4*d2*d4^3*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*d2^3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3)^2 + 4*d2^2*d4^2*cos(alpha2)^2*cos(alpha3)^2*sin(alpha1)^2 + 4*d2*d4^3*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*d2^3*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a1^2*d4^2*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha3)^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2^2*d4^2*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 8*a1^2*d3*z*cos(alpha1)*cos(alpha2) - 4*d2*d3*r*cos(alpha2)*sin(alpha1)^2 - 4*d3*d4*r*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d2*d3*cos(alpha1)^2*cos(alpha2) + 4*a1^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a2^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a3^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*d2*d3*d4^2*cos(alpha2)*sin(alpha1)^2 + 4*d2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*d2*d3*d4^2*cos(alpha2)*cos(alpha3)^2*sin(alpha1)^2 + 8*d2^2*d3*d4*cos(alpha2)^2*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2)^2 - 8*a1^2*d4*z*cos(alpha1)*cos(alpha2)*cos(alpha3) - 4*d2*d4*r*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d4*z*cos(alpha1)*sin(alpha2)*sin(alpha3) - 4*d2*d4*r*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a1^2*d2*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3) + 4*a1^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 12*d2*d3^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d2*d4*cos(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a1^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a2^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a3^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*d2*d3^2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*a2*a3*d2*d3*cos(alpha2)*sin(alpha1)^2 - 8*a2*a3*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3) + 8*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2)*sin(alpha3) + 8*a1^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*d2^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)*sin(alpha2)*sin(alpha3) + 8*a1^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*d2^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*d2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*a2*a3*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a2*a3*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3);
                b = 8*a3*d2^3*sin(alpha1)^2*sin(alpha2) + 8*a3^3*d2*sin(alpha1)^2*sin(alpha2) + 8*a2*d4^3*sin(alpha1)^2*sin(alpha3) + 8*a2^3*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*z*cos(alpha1)*sin(alpha2) - 8*a3*d2*r*sin(alpha1)^2*sin(alpha2) - 8*a2*d4*r*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d2*cos(alpha1)^2*sin(alpha2) + 8*a1^2*a3*d2*sin(alpha1)^2*sin(alpha2) - 16*a2*a3^2*d2*sin(alpha1)^2*sin(alpha2) + 8*a2^2*a3*d2*sin(alpha1)^2*sin(alpha2) - 8*a1^2*a2*d4*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a2*a3^2*d4*sin(alpha1)^2*sin(alpha3) - 16*a2^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d3^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d2^2*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d4^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d3^2*d4*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3) - 16*a1^2*a3*d4*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3) + 16*a2*d2*d4^2*sin(alpha1)^2*sin(alpha2)*sin(alpha3)^2 + 16*a3*d2^2*d4*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3) + 16*a1^2*a3*d3*cos(alpha1)^2*cos(alpha2)*sin(alpha2) + 16*a1^2*a3*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a3*d2^2*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2) + 16*a1^2*a3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2);
                c = 2*a1^4*sin(alpha1)^2 + 2*a2^4*sin(alpha1)^2 + 2*a3^4*sin(alpha1)^2 + 2*d2^4*sin(alpha1)^2 + 2*d3^4*sin(alpha1)^2 + 2*d4^4*sin(alpha1)^2 + 2*r^2*sin(alpha1)^2 + 8*a1^2*z^2 + 8*a1^2*d2^2*cos(alpha1)^2 - 4*a1^2*a2^2*sin(alpha1)^2 + 12*a1^2*a3^2*sin(alpha1)^2 - 4*a2^2*a3^2*sin(alpha1)^2 + 4*a1^2*d2^2*sin(alpha1)^2 + 4*a1^2*d3^2*sin(alpha1)^2 + 4*a2^2*d2^2*sin(alpha1)^2 + 4*a1^2*d4^2*sin(alpha1)^2 + 4*a2^2*d3^2*sin(alpha1)^2 + 4*a3^2*d2^2*sin(alpha1)^2 + 4*a2^2*d4^2*sin(alpha1)^2 + 4*a3^2*d3^2*sin(alpha1)^2 + 4*a3^2*d4^2*sin(alpha1)^2 + 4*d2^2*d3^2*sin(alpha1)^2 + 4*d2^2*d4^2*sin(alpha1)^2 + 4*d3^2*d4^2*sin(alpha1)^2 - 4*a1^2*r*sin(alpha1)^2 - 4*a2^2*r*sin(alpha1)^2 - 4*a3^2*r*sin(alpha1)^2 - 4*d2^2*r*sin(alpha1)^2 - 4*d3^2*r*sin(alpha1)^2 - 4*d4^2*r*sin(alpha1)^2 + 8*a1^2*d3^2*cos(alpha1)^2*cos(alpha2)^2 + 16*a1^2*a3^2*cos(alpha1)^2*sin(alpha2)^2 - 16*a1^2*a3^2*cos(alpha2)^2*sin(alpha1)^2 + 8*d2^2*d3^2*cos(alpha2)^2*sin(alpha1)^2 + 8*d3^2*d4^2*cos(alpha3)^2*sin(alpha1)^2 - 8*a1^2*d3^2*sin(alpha1)^2*sin(alpha2)^2 + 16*a3^2*d2^2*sin(alpha1)^2*sin(alpha2)^2 - 16*a1^2*d4^2*sin(alpha1)^2*sin(alpha3)^2 + 16*a2^2*d4^2*sin(alpha1)^2*sin(alpha3)^2 + 8*d2*d3^3*cos(alpha2)*sin(alpha1)^2 + 8*d2^3*d3*cos(alpha2)*sin(alpha1)^2 + 8*d3*d4^3*cos(alpha3)*sin(alpha1)^2 + 8*d3^3*d4*cos(alpha3)*sin(alpha1)^2 - 16*a1^2*d2*z*cos(alpha1) + 8*d2*d4^3*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*d2^3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3)^2 + 8*d2^2*d4^2*cos(alpha2)^2*cos(alpha3)^2*sin(alpha1)^2 - 8*a1^2*d4^2*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 + 8*a1^2*d4^2*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3)^2 - 8*a1^2*d4^2*cos(alpha3)^2*sin(alpha1)^2*sin(alpha2)^2 - 8*d2^2*d4^2*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 16*a1^2*d3*z*cos(alpha1)*cos(alpha2) - 8*d2*d3*r*cos(alpha2)*sin(alpha1)^2 - 8*d3*d4*r*cos(alpha3)*sin(alpha1)^2 + 16*a1^2*d2*d3*cos(alpha1)^2*cos(alpha2) + 8*a1^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a2^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a3^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a3^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*d2*d3*d4^2*cos(alpha2)*sin(alpha1)^2 + 8*d2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 16*d2*d3*d4^2*cos(alpha2)*cos(alpha3)^2*sin(alpha1)^2 + 16*d2^2*d3*d4*cos(alpha2)^2*cos(alpha3)*sin(alpha1)^2 - 16*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2)^2 - 16*a1^2*d4*z*cos(alpha1)*cos(alpha2)*cos(alpha3) - 8*d2*d4*r*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 16*a1^2*d2*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3) + 8*a1^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a2^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a3^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 24*d2*d3^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 16*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3) + 48*a2*a3*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3);
                d = 8*a3*d2^3*sin(alpha1)^2*sin(alpha2) + 8*a3^3*d2*sin(alpha1)^2*sin(alpha2) + 8*a2*d4^3*sin(alpha1)^2*sin(alpha3) + 8*a2^3*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*z*cos(alpha1)*sin(alpha2) - 8*a3*d2*r*sin(alpha1)^2*sin(alpha2) - 8*a2*d4*r*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d2*cos(alpha1)^2*sin(alpha2) + 8*a1^2*a3*d2*sin(alpha1)^2*sin(alpha2) + 16*a2*a3^2*d2*sin(alpha1)^2*sin(alpha2) + 8*a2^2*a3*d2*sin(alpha1)^2*sin(alpha2) - 8*a1^2*a2*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a2*a3^2*d4*sin(alpha1)^2*sin(alpha3) + 16*a2^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d3^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d2^2*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d4^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d3^2*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*d4*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3) - 16*a2*d2*d4^2*sin(alpha1)^2*sin(alpha2)*sin(alpha3)^2 - 16*a3*d2^2*d4*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3) + 16*a1^2*a3*d3*cos(alpha1)^2*cos(alpha2)*sin(alpha2) + 16*a1^2*a3*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a3*d2^2*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2) + 16*a1^2*a3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2);
                e = a1^4*sin(alpha1)^2 + a2^4*sin(alpha1)^2 + a3^4*sin(alpha1)^2 + d2^4*sin(alpha1)^2 + d3^4*sin(alpha1)^2 + d4^4*sin(alpha1)^2 + r^2*sin(alpha1)^2 + 4*a1^2*z^2 + 4*a1^2*d2^2*cos(alpha1)^2 - 2*a1^2*a2^2*sin(alpha1)^2 - 2*a1^2*a3^2*sin(alpha1)^2 + 6*a2^2*a3^2*sin(alpha1)^2 + 2*a1^2*d2^2*sin(alpha1)^2 + 2*a1^2*d3^2*sin(alpha1)^2 + 2*a2^2*d2^2*sin(alpha1)^2 + 2*a1^2*d4^2*sin(alpha1)^2 + 2*a2^2*d3^2*sin(alpha1)^2 + 2*a3^2*d2^2*sin(alpha1)^2 + 2*a2^2*d4^2*sin(alpha1)^2 + 2*a3^2*d3^2*sin(alpha1)^2 + 2*a3^2*d4^2*sin(alpha1)^2 + 2*d2^2*d3^2*sin(alpha1)^2 + 2*d2^2*d4^2*sin(alpha1)^2 + 2*d3^2*d4^2*sin(alpha1)^2 + 4*a2*a3^3*sin(alpha1)^2 + 4*a2^3*a3*sin(alpha1)^2 - 2*a1^2*r*sin(alpha1)^2 - 2*a2^2*r*sin(alpha1)^2 - 2*a3^2*r*sin(alpha1)^2 - 2*d2^2*r*sin(alpha1)^2 - 2*d3^2*r*sin(alpha1)^2 - 2*d4^2*r*sin(alpha1)^2 - 4*a1^2*a2*a3*sin(alpha1)^2 + 4*a2*a3*d2^2*sin(alpha1)^2 + 4*a2*a3*d3^2*sin(alpha1)^2 + 4*a2*a3*d4^2*sin(alpha1)^2 + 4*a1^2*d3^2*cos(alpha1)^2*cos(alpha2)^2 + 4*d2^2*d3^2*cos(alpha2)^2*sin(alpha1)^2 + 4*d3^2*d4^2*cos(alpha3)^2*sin(alpha1)^2 - 4*a1^2*d3^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2*d3^3*cos(alpha2)*sin(alpha1)^2 + 4*d2^3*d3*cos(alpha2)*sin(alpha1)^2 + 4*d3*d4^3*cos(alpha3)*sin(alpha1)^2 + 4*d3^3*d4*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d2*z*cos(alpha1) - 4*a2*a3*r*sin(alpha1)^2 + 4*d2*d4^3*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*d2^3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3)^2 + 4*d2^2*d4^2*cos(alpha2)^2*cos(alpha3)^2*sin(alpha1)^2 - 4*d2*d4^3*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*d2^3*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a1^2*d4^2*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha3)^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2^2*d4^2*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 8*a1^2*d3*z*cos(alpha1)*cos(alpha2) - 4*d2*d3*r*cos(alpha2)*sin(alpha1)^2 - 4*d3*d4*r*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d2*d3*cos(alpha1)^2*cos(alpha2) + 4*a1^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a2^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a3^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*d2*d3*d4^2*cos(alpha2)*sin(alpha1)^2 + 4*d2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*d2*d3*d4^2*cos(alpha2)*cos(alpha3)^2*sin(alpha1)^2 + 8*d2^2*d3*d4*cos(alpha2)^2*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2)^2 - 8*a1^2*d4*z*cos(alpha1)*cos(alpha2)*cos(alpha3) - 4*d2*d4*r*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d4*z*cos(alpha1)*sin(alpha2)*sin(alpha3) + 4*d2*d4*r*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a1^2*d2*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3) + 4*a1^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 12*d2*d3^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d2*d4*cos(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*a1^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*a2^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*a3^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*d2*d3^2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a2*a3*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a2*a3*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3) - 8*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2)*sin(alpha3) - 8*a1^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*d2^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)*sin(alpha2)*sin(alpha3) - 8*a1^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*d2^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*d2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a2*a3*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a2*a3*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3);
                delta0 = c^2-3*b*d+12*a*e;
                delta1 = 2*c^3-9*b*c*d+27*b^2*e+27*a*d^2-72*a*c*e;
                delta =  -(delta1^2-4*delta0^3)/27;
                P = 8*a*c-3*b^2;
                R = b^3+8*d*a^2-4*a*b*c;
                D = 64*a^3*e-16*a^2*c^2+16*a*b^2*c-16*a^2*b*d-3*b^4;
                if delta < 0
                    plot3(x,y,z,'color','y','marker','.')
                elseif delta > 0 
                    if P < 0 && D < 0
                        plot3(x,y,z,'color','b','marker','.')
                    elseif P > 0 || D > 0
                        plot3(x,y,z,'color','r','marker','.')
                    end             
                else
                    plot3(x,y,z,'color','k','marker','.')
                end
           
        end
    end
    end
        
xlabel('x(m)')
ylabel('y(m)')
zlabel('z(m)')

%     p = (8*a*c-3*b^2)/(8*a^2);
%     q = (b^3-4*a*b*c+8*a^2*d)/(8*a^3);
%     Q = ((delta1+(delta1^2-4*delta0^3)^0.5)/2)^(1/3);
%     S = 0.5*(-2/3*p+1/(3*a)*(Q+delta0/Q))^0.5;
%     x1 = -b/(4*a)-S+0.5*(-4*S^2-2*p+q/S)^0.5;
%     x2 = -b/(4*a)-S-0.5*(-4*S^2-2*p+q/S)^0.5;
%     x3 = -b/(4*a)+S+0.5*(-4*S^2-2*p-q/S)^0.5;
%     x4 = -b/(4*a)+S-0.5*(-4*S^2-2*p-q/S)^0.5;
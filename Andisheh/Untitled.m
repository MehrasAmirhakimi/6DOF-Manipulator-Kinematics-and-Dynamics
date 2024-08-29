clc
clear all %#ok
close all

% a4, a5, d5 must be zero
a1 = 0.07*10;
a2 = 0.4318*10;
a3 = 0;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0.65*10;

% theta1 = 0  *pi/180;
% theta2 = 0  *pi/180;
% theta3 = 0  *pi/180;
% theta4 = 0  *pi/180;
% theta5 = 0  *pi/180;
% theta6 = 0  *pi/180;

theta1 = 30  *pi/180;
theta2 = -45  *pi/180;
theta3 = 20  *pi/180;
theta4 = 45  *pi/180;
theta5 = 20  *pi/180;
theta6 = 10  *pi/180;

DH = [-pi/2, a1, d1, theta1;
          0, a2, d2, theta2;
      -pi/2, a3, d3, theta3;
       pi/2,  0, d4, theta4;
      -pi/2,  0,  0, theta5;
          0,  0, d6, theta6];
      
T = ForKin(DH, 1);


n = size(DH, 1);
T = eye(4); 
        for i = n:-1:1
            alpha = DH(i, 1);
            a = DH(i, 2);
            d = DH(i, 3);
            theta = DH(i, 4);
            T = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), a*cos(theta);
                sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
                0, sin(alpha), cos(alpha), d;
                0, 0, 0, 1] * T;
        end
 









sol = PieperIK(DH, T) * 180/pi;
Rsol = real(sol)
figure
ManipolatorShow(DH)
view(45,30)
figure
for i=1:8
    theta1 = Rsol(i,1)  *pi/180;
    theta2 = Rsol(i,2)  *pi/180;
    theta3 = Rsol(i,3)  *pi/180;
    theta4 = Rsol(i,4)  *pi/180;
    theta5 = Rsol(i,5)  *pi/180;
    theta6 = Rsol(i,6)  *pi/180;
    DHT = [-pi/2, a1, d1, theta1;
          0, a2, d2, theta2;
      -pi/2, a3, d3, theta3;
      +pi/2,  0, d4, theta4;
      -pi/2,  0,  0, theta5;
          0,  0,  0, theta6];
    subplot(2,4,i)
    ManipolatorShow(DHT)
    view(45,30)
end

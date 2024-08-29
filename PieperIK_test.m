clc
clear all
close all

% a4, a5, d5 must be zero


a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0.25*10;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0;

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
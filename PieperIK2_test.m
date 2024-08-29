clc
clear all
close all

a1 = 2;
a2 = 4;
a3 = 1;


d2 = 15;
d3 = -2;
d4 = 4;

theta1 = 30  *pi/180;
theta2 = 50  *pi/180;
theta3 = 40  *pi/180;
theta4 = 45  *pi/180;
theta5 = 10  *pi/180;
theta6 = 60  *pi/180;

dh = [   0,  0,  0, theta1;
     -pi/2, a1, d2, theta2;
         0, a2, d3, theta3;
     -pi/2, a3, d4, theta4;
      pi/2,  0,  0, theta5;
     -pi/2,  0,  0, theta6];
      
T = ForKin(dh, 2)

sol = PieperIK2(dh, T);
imag(sol)
real(sol)*180/pi
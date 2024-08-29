% OSJacobi test on 5 DOF
clc
clear all
close all


a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0.25*10;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0;

theta1 =  60*pi/180;
theta2 = -30*pi/180;
theta3 =  45*pi/180;
theta4 =  20*pi/180;
theta5 = -40*pi/180;
theta6 =  25*pi/180;

DH = [-pi/2, a1, d1, theta1;
          0, a2, d2, theta2;
      -pi/2, a3, d3, theta3;
       pi/2,  0, d4, theta4;
      -pi/2,  0,  0, theta5;
          0,  0, d6, theta6];
      
J5dof = Jacobi2(DH(1:5, :));
J6dof = Jacobi2(DH);
det5 = det(J5dof*J5dof')
det6 = det(J6dof)
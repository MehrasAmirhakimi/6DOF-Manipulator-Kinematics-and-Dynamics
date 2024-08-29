clc
clear all

syms theta1 theta2 theta3 theta4 theta5 theta6 real

% a4, a5, d5 must be zero
a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0.065*10;

% theta1 = 0  *pi/180;
% theta2 = -90  *pi/180;
% theta3 = -90  *pi/180;
% theta4 = 0  *pi/180;
% theta5 = 0  *pi/180;
% theta6 = 0  *pi/180;

% theta1 = 30  *pi/180;
% theta2 = -45  *pi/180;
% theta3 = 20  *pi/180;
% theta4 = 45  *pi/180;
% theta5 = 20  *pi/180;
% theta6 = 10  *pi/180;

DH = [-pi/2, a1, d1, theta1;
          0, a2, d2, theta2;
      -pi/2, a3, d3, theta3;
       pi/2,  0, d4, theta4;
      -pi/2,  0,  0, theta5;
          0,  0, d6, theta6];
J = Jacobi(DH)
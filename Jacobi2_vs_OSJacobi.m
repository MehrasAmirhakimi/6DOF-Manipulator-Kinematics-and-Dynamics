% Jacobi2 vs OSJacobi

clc
clear all

a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0;
d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0.065*10;

theta1 = 30  *pi/180;
theta2 = -45 *pi/180;
theta3 = 20  *pi/180;
theta4 = 45  *pi/180;
theta5 = 20  *pi/180;
theta6 = 10  *pi/180;
thetas = [theta1 theta2 theta3 theta4 theta5 theta6]';

DH = [-pi/2, a1, d1, theta1;
          0, a2, d2, theta2;
      -pi/2, a3, d3, theta3;
       pi/2,  0, d4, theta4;
      -pi/2,  0,  0, theta5;
          0,  0, d6, theta6];
      
      
J2 = zeros(6, 6, 1000);
J3 = J2;

for i = 1:1000
   DH(:, 4) =  rand(6, 1).*thetas;
   J2(:, :, i) = Jacobi2(DH);
   J3(:, :, i) = OSJacobi(DH);
end
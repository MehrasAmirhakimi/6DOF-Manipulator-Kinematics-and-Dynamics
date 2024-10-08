clear all;
clc;
% syms a1 a2 a3 a4 a5 a6 alpha1 alpha2 alpha3 alpha4 alpha5 alpha6 theta1 theta2 theta3 theta4 theta5 theta6 d1 d2 d3 d4 d5 d6 r z u;
% C = @(theta)cos(theta);
% S = @(theta)sin(theta);
syms theta3;
a1=1;
a2=2;
a3=2;
alpha1=-pi/2;
alpha2=0;
alpha3=-pi/2;
d2=0;
d3=0.5;
d4=0.5;
r=1.2;
z=0.5;
C = @(u)(1-u^2)/(1+u^2);
S = @(u)2*u/(1+u^2);
f1 = a3*C(theta3) + d4*S(alpha3)*S(theta3) + a2;
f2 = a3*C(alpha2)*S(theta3) - d4*S(alpha3)*C(alpha2)*C(theta3) - d4*S(alpha2)*C(alpha3) - d3*S(alpha2);
f3 = a3*S(alpha2)*S(theta3) - d4*S(alpha3)*S(alpha2)*C(theta3) + d4*C(alpha2)*C(alpha3) + d3*C(alpha2);
k1 = f1;
k2 = -f2;
k3 = f1^2 + f2^2 + f3^2 + a1^2 + d2^2 + 2*d2*f3;
k4 = f3*C(alpha1) + d2*C(alpha1);
B = (r - k3)^2/(4*a1^2) + (z - k4)^2/(S(alpha1))^2 - k1^2 - k2^2;
% D = expand(B);
% E = subs(D, [cos(theta3), sin(theta3)], [(1-u^2)/(1+u^2), 2*u/(1+u^2)]);
% F = subs(E, [a1, a2, a3, alpha1, alpha2, alpha3, d2, d3, d4, r, z], [1, 2, 2, -pi/2, 0, -pi/2, 0, 0.5, 0.5, 1.2, 0.5]);
solve(B)
clear all;
clc;
syms a1 a2 a3 a4 a5 a6 alpha1 alpha2 alpha3 alpha4 alpha5 alpha6 theta1 theta2 theta3 theta4 theta5 theta6 d1 d2 d3 d4 d5 d6 r z u;
C = @(theta)cos(theta);
S = @(theta)sin(theta);
k1 = a2 + d4*S(theta3)*S(alpha3) + a3*C(theta3);
k2 = -C(alpha2)*(-d4*C(theta3)*S(alpha3)+a3*S(theta3)) + S(alpha2)*(d3 + d4*C(alpha3));
k3 = a1^2 + d2^2 + a2^2 + d3^2 + a3^2 + d4^2 + 2*d2*d3*C(alpha2) + 2*d2*d4*C(alpha2)*C(alpha3) + 2*d3*d4*C(alpha3) + C(theta3)*(2*a2*a3 - 2*d2*d4*S(alpha2)*S(alpha3)) + S(theta3)*(2*a3*d2*S(alpha2) + 2*a2*d4*S(alpha3));
k4 = C(alpha1)*(a3*S(theta3)*S(alpha2) + d3*C(alpha2) + d2 + d4*(-C(theta3)*S(alpha2)*S(alpha3) + C(alpha2)*C(alpha3)));
B = (r - k3)^2/(4*a1^2) + (z - k4)^2/(S(alpha1))^2 - k1^2 - k2^2;
D = subs(B, [cos(theta3), sin(theta3)], [(1-u^2)/(1+u^2), 2*u/(1+u^2)]);
[N, DD] = numden(D);
%N = subs(N, [a1, a2, a3, alpha1, alpha2, alpha3, d2, d3, d4, r, z], [5, 3, 6, -pi/2, 0, -pi/2, 3.2, 2.5, 5.5, 150, 10]);
co = coeffs(N, u)
%sol = solve(N)
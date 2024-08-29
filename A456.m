clc
clear all
C = @(theta)cos(theta);
S = @(theta)sin(theta);
syms theta4 alpha4 theta5 alpha5 theta6 alpha6

A4 = [C(theta4), 0, S(theta4)*S(alpha4);
    S(theta4), 0, -C(theta4)*S(alpha4);
    0, S(alpha4), 0];
A5 = [C(theta5), 0, S(theta5)*S(alpha5);
    S(theta5), 0, -C(theta5)*S(alpha5);
    0, S(alpha5), 0];
A6 = [C(theta6), -S(theta6)*C(alpha6), 0;
    S(theta6), C(theta6)*C(alpha6), 0;
    0, 0, C(alpha6)];
A = A4*A5*A6;
B = expand(A)
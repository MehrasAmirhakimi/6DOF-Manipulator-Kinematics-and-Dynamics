% clc
% clear all

syms L1 L2 theta1 theta2 thdot1 thdot2 thddot1 thddot2 m1 m2 real

DH = [0 L1 0 theta1;
      0 L2 0 theta2];
thdot = [thdot1; thdot2];
thddot = [thddot1; thddot2];
m = [m1 m2];

I = zeros(3, 3, 2);
Pc = zeros(3, 2);
FN = zeros(6, 1);

Torque = DynamicTorque(DH, thdot, thddot, m, I, Pc, FN);
% OK
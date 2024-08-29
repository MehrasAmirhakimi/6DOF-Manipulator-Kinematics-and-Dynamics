clc
clear all
%% input parameters
syms alpha1 alpha2 alpha3 alpha4 alpha5 alpha6...
    a1 a2 a3 a4 a5 a6...
    d1 d2 d3 d4 d5 d6...
    theta1 theta2 theta3 theta4 theta5 theta6...
    thdot1 thdot2 thdot3 thdot4 thdot5 thdot6...
    thddot1 thddot2 thddot3 thddot4 thddot5 thddot6...
    m1 m2 m3 m4 m5 m6...
    Ixx1 Ixy1 Ixz1 Iyx1 Iyy1 Iyz1 Izx1 Izy1 Izz1...
    Ixx2 Ixy2 Ixz2 Iyx2 Iyy2 Iyz2 Izx2 Izy2 Izz2...
    Ixx3 Ixy3 Ixz3 Iyx3 Iyy3 Iyz3 Izx3 Izy3 Izz3...
    Ixx4 Ixy4 Ixz4 Iyx4 Iyy4 Iyz4 Izx4 Izy4 Izz4...
    Ixx5 Ixy5 Ixz5 Iyx5 Iyy5 Iyz5 Izx5 Izy5 Izz5...
    Ixx6 Ixy6 Ixz6 Iyx6 Iyy6 Iyz6 Izx6 Izy6 Izz6...
    Pc1x Pc2x Pc3x Pc4x Pc5x Pc6x...
    Pc1y Pc2y Pc3y Pc4y Pc5y Pc6y...
    Pc1z Pc2z Pc3z Pc4z Pc5z Pc6z...
    ff1 ff2 ff3 fn1 fn2 fn3 g
    
DH = [alpha1, a1, d1, theta1;
    alpha2, a2, d2, theta2;
    alpha3, a3, d3, theta3;
    alpha4, a4, d4, theta4;
    alpha5, a5, d5, theta5;
    alpha6, a6, d6, theta6];

%theta = [theta1; theta2; theta3; theta4; theta5; theta6];
thdot = [thdot1; thdot2; thdot3; thdot4; thdot5; thdot6];
thddot = [thddot1; thddot2; thddot3; thddot4; thddot5; thddot6];

I = zeros(3, 3, 6);
I = sym(I);
I(:, :, 1) = [Ixx1, Ixy1, Ixz1; Iyx1, Iyy1, Iyz1; Izx1, Izy1, Izz1];
I(:, :, 2) = [Ixx2, Ixy2, Ixz2; Iyx2, Iyy2, Iyz2; Izx2, Izy2, Izz2];
I(:, :, 3) = [Ixx3, Ixy3, Ixz3; Iyx3, Iyy3, Iyz3; Izx3, Izy3, Izz3];
I(:, :, 4) = [Ixx4, Ixy4, Ixz4; Iyx4, Iyy4, Iyz4; Izx4, Izy4, Izz4];
I(:, :, 5) = [Ixx5, Ixy5, Ixz5; Iyx5, Iyy5, Iyz5; Izx5, Izy5, Izz5];
I(:, :, 6) = [Ixx6, Ixy6, Ixz6; Iyx6, Iyy6, Iyz6; Izx6, Izy6, Izz6];
% I = sym('I', [3, 3, 6]);
m = [m1 m2 m3 m4 m5 m6];

Z = [0; 0; 1];

T = zeros(4, 4, 6);
T = sym(T);
P = zeros(3, 6);
P = sym(P);
Pc = [Pc1x Pc2x Pc3x Pc4x Pc5x Pc6x;
      Pc1y Pc2y Pc3y Pc4y Pc5y Pc6y;
      Pc1z Pc2z Pc3z Pc4z Pc5z Pc6z];
  
% Pc = sym('Pc', [3, 6]);
for i =1:6
   T(:, :, i) = ForKin(DH(i, :), 1);
   P(:, i) = T(1:3, 4, i);
end

R = T(1:3, 1:3, :);

%% outputs
omega = zeros(3, 7);
omega = sym(omega);
omegadot = zeros(3, 7);
omegadot = sym(omegadot);

v = zeros(3, 7);
v = sym(v);
vdot = zeros(3, 7);
vdot = sym(vdot);
vdot(3, 1) = g;

vcdot = zeros(3, 6);
vcdot = sym(vcdot);

for i = 1:6
    omega(:, i+1) = R(:, :, i)'*(omega(:, i) + thdot(i)*Z);
    omegadot(:, i+1) = R(:, :, i)'*(omegadot(:, i) + cross(omega(:, i), thdot(i)*Z) + thddot(i)*Z);
    v(:, i+1) = R(:, :, i)'*(v(:, i) + cross(thdot(i)*Z + omega(:, i), P(:, i)));
    vdot(:, i+1) = R(:, :, i)'*(vdot(:, i) + cross(thddot(i)*Z + omegadot(:, i), P(:, i)) + cross(thdot(i)*Z + 2*omega(:, i), cross(thdot(i)*Z, P(:, i))) + cross(omega(:, i), cross(omega(:, i), P(:, i))));
    vcdot(:, i) = vdot(:, i+1) + cross(omegadot(:, i+1), Pc(:, i)) + cross(omega(:, i+1), cross(omega(:, i+1), Pc(:, i)));
end

F = zeros(3, 6);
F = sym(F);
N = zeros(3, 6);
N = sym(N);

f = zeros(3, 7);
f = sym(f);
ff = [ff1 ff2 ff3]';
f(:, 7) = ff;
n = zeros(3, 7);
n = sym(n);
fn = [fn1 fn2 fn3]';
n(:, 7) = fn;

Torque = zeros(1, 7);
Torque = sym(Torque);

for i = 6:-1:1
    i
    F(:, i) = m(i)*vcdot(:, i);
    N(:, i) = I(:, :, i)*omegadot(:, i+1) + cross(omega(:, i+1), I(:, :, i)*omega(:, i+1));
    f(:, i) = R(:, :, i)*(f(:, i+1) + F(:, i));
    n(:, i) = R(:, :, i)*(n(:, i+1) + N(:, i) + cross(Pc(:, i), F(:, i))) + cross(P(:, i), f(:, i));
    Torque(i) = n(:, i)'*Z;
    i
end


function Torque = DynamicTorque(DH, thdot, thddot, m, I, Pc, FN)
%% variables

nd = size(DH, 1);

Z = [0; 0; 1];

T = zeros(4, 4, nd);
T(4, 4, :) = 1;
R = T(1:3, 1:3, :);
P = zeros(3, nd);
omega = zeros(3, nd+1);
omegadot = zeros(3, nd+1);

v = zeros(3, nd+1);
vdot = zeros(3, nd+1);


vcdot = zeros(3, nd);
F = zeros(3, nd);
N = zeros(3, nd);

f = zeros(3, nd+1);

n = zeros(3, nd+1);

Torque = zeros(1, nd);

if isa(DH, 'sym')
    T = sym(T);
    P = sym(P);
    omega = sym(omega);
    omegadot = sym(omegadot);
    v = sym(v);
    vdot = sym(vdot);
    vcdot = sym(vcdot);
    F = sym(F);
    N = sym(N);
    f = sym(f);
    n = sym(n);
    Torque = sym(Torque);
    syms g real
else
    g = 9.81;
end

vdot(2, 1) = g;
ff = [FN(1) FN(2) FN(3)]';
f(:, nd+1) = ff;

fn = [FN(4) FN(5) FN(6)]';
n(:, nd+1) = fn;

for i =1:nd
   alpha = DH(i, 1);
   a = DH(i, 2);
   d = DH(i, 3);
   theta = DH(i, 4);
   T(1, 1, i) = cos(theta);
   T(1, 2, i) = -sin(theta)*cos(alpha);
   T(1, 3, i) = sin(theta)*sin(alpha);
   T(1, 4, i) = a*cos(theta);
   T(2, 1, i) = sin(theta);
   T(2, 2, i) = cos(theta)*cos(alpha);
   T(2, 3, i) = -cos(theta)*sin(alpha);
   T(2, 4, i) = a*sin(theta);
   T(3, 2, i) = sin(alpha);
   T(3, 3, i) = cos(alpha);
   T(3, 4, i) = d;
   R(:, :, i) = T(1:3, 1:3, i);
   P(:, i) = T(1:3, 4, i);
end



%% outputs

for i = 1:nd
    omega(:, i+1) = R(:, :, i)'*(omega(:, i) + thdot(i)*Z);
    omegadot(:, i+1) = R(:, :, i)'*(omegadot(:, i) + cross(omega(:, i), thdot(i)*Z) + thddot(i)*Z);
    v(:, i+1) = R(:, :, i)'*(v(:, i) + cross(thdot(i)*Z + omega(:, i), P(:, i)));
    vdot(:, i+1) = R(:, :, i)'*(vdot(:, i) + cross(thddot(i)*Z + omegadot(:, i), P(:, i)) + cross(thdot(i)*Z + 2*omega(:, i), cross(thdot(i)*Z, P(:, i))) + cross(omega(:, i), cross(omega(:, i), P(:, i))));
    vcdot(:, i) = vdot(:, i+1) + cross(omegadot(:, i+1), Pc(:, i)) + cross(omega(:, i+1), cross(omega(:, i+1), Pc(:, i)));
end


for i = nd:-1:1
    
    F(:, i) = m(i)*vcdot(:, i);
    N(:, i) = I(:, :, i)*omegadot(:, i+1) + cross(omega(:, i+1), I(:, :, i)*omega(:, i+1));
    f(:, i) = R(:, :, i)*(f(:, i+1) + F(:, i));
    n(:, i) = R(:, :, i)*(n(:, i+1) + N(:, i) + cross(Pc(:, i), F(:, i))) + cross(P(:, i), f(:, i));
    Torque(i) = n(:, i)'*Z;
    
end


end
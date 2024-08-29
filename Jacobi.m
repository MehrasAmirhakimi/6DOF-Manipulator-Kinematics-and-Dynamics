function J = Jacobi(DH, symthdot)%%% ,theta1, theta2 , theta3, theta4, theta5, theta6)

nd = size(DH, 1);
%%% thetas = [theta1, theta2 , theta3, theta4, theta5, theta6];
Z = [0; 0; 1];

T = zeros(4, 4, nd);
T = sym(T);
TT = eye(4, 4);
P = zeros(3, nd);
P = sym(P);

for i = nd:-1:1
    alpha = DH(i, 1);
    a = DH(i, 2);
    d = DH(i, 3);
    teta = DH(i, 4);
    %%% teta = thetas(i);
    T(:, :, i) = [cos(teta), -sin(teta)*cos(alpha), sin(teta)*sin(alpha), a*cos(teta);
                  sin(teta), cos(teta)*cos(alpha), -cos(teta)*sin(alpha), a*sin(teta);
                  0, sin(alpha), cos(alpha), d;
                  0, 0, 0, 1];
    TT = T(:, :, i)*TT;
    P(:, i) = T(1:3, 4, i);
end

R = T(1:3, 1:3, :);
RR = TT(1:3, 1:3);

omega = zeros(3, nd+1);
omega = sym(omega);

v = zeros(3, nd+1);
v = sym(v);

for i = 1:nd
    omega(:, i+1) = R(:, :, i)'*(omega(:, i) + symthdot(i)*Z);
    v(:, i+1) = R(:, :, i)'*(v(:, i) + cross(symthdot(i)*Z + omega(:, i), P(:, i)));
end

vv = RR*v(:, nd+1);
ww = RR*omega(:, nd+1);
V = [vv; ww];
J = jacobian(V, symthdot);

end
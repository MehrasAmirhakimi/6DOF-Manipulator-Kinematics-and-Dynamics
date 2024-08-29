function y = R4_56(DH, Rd, th123)

theta4 = 0;
thetas = [th123, theta4];
R = eye(3);

for i = 1:4
    alpha = DH(i, 1);
    a = DH(i, 2);
    d = DH(i, 3);
    theta = thetas(i);
    R = R * [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha);
            sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha);
            0, sin(alpha), cos(alpha)];
end

y = transpose(R) * Rd;

end
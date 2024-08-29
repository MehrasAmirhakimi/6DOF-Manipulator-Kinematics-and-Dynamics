function y = R456(DH, Rd, th123)

R = eye(3);

for i = 1:3
    alpha = DH(i, 1);
    a = DH(i, 2);
    d = DH(i, 3);
    theta = th123(i);
    R = R * [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha);
            sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha);
            0, sin(alpha), cos(alpha)];
end

y = transpose(R) * Rd;

end
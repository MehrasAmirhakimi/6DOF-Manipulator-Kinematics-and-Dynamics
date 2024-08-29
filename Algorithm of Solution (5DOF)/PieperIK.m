function [sol, realindex] = PieperIK(DH, T)

C = @(theta)cos(theta);
S = @(theta)sin(theta);
%% importing parameters

% importing DH parameters

if DH(6, 1) ~= 0 || DH(6, 2) ~= 0 || DH(6, 3) ~= 0
    alphat = DH(6, 1);
    at = DH(6, 2);
    dt = DH(6, 3);
    Tt = [1,         0,          0, at;
          0, C(alphat), -S(alphat), 0;
          0, S(alphat),  C(alphat), dt;
          0,         0,          0, 1];
    T = T/Tt;
    DH(6, 1) = 0;
    DH(6, 2) = 0;
    DH(6, 3) = 0;
end


alpha1 = DH(1, 1);
alpha2 = DH(2, 1);
alpha3 = DH(3, 1);
alpha4 = DH(4, 1);
alpha5 = DH(5, 1);
alpha6 = DH(6, 1);

a1 = DH(1, 2);
a2 = DH(2, 2);
a3 = DH(3, 2);
a4 = DH(4, 2);
a5 = DH(5, 2);
a6 = DH(6, 2);

d1 = DH(1, 3);
d2 = DH(2, 3);
d3 = DH(3, 3);
d4 = DH(4, 3);
d5 = DH(5, 3);
d6 = DH(6, 3);

% importing goal position and orientation

r11 = T(1, 1);
r21 = T(2, 1);
r31 = T(3, 1);
r12 = T(1, 2);
r22 = T(2, 2);
r32 = T(3, 2);
r13 = T(1, 3);
r23 = T(2, 3);
r33 = T(3, 3);
x = T(1, 4);
y = T(2, 4);
z = T(3, 4);

%% Solving procedure
sol = zeros(8, 6);
realindex = ones(8, 1);
z = z - d1;
r = x^2 + y^2 + z^2;


%% theta3 & theta2

if a1 == 0
    a = 2*a2*a3 - 2*d2*d4*S(alpha2)*S(alpha3);
    b = 2*a3*d2*S(alpha2) + 2*a2*d4*S(alpha3);
    c = r - (a1^2 + d2^2 + a2^2 + d3^2 + a3^2 + d4^2 + 2*d2*d3*C(alpha2) + 2*d2*d4*C(alpha2)*C(alpha3) + 2*d3*d4*C(alpha3));
    theta31 = atan2(b, a) - atan2((a^2 + b^2 - c^2)^0.5, c);
    theta32 = atan2(b, a) + atan2((a^2 + b^2 - c^2)^0.5, c);
    sol(1, 3) = theta31;
    sol(2, 3) = theta32;
    
    for i =1:2
        theta3 = sol(i, 3);
       if isreal(theta3)
           sol(i + 2, 3) = theta3;
           k1 = a2 + d4*S(theta3)*S(alpha3) + a3*C(theta3);
           k2 = -C(alpha2)*(-d4*C(theta3)*S(alpha3)+a3*S(theta3)) + S(alpha2)*(d3 + d4*C(alpha3));
           k4 = C(alpha1)*(a3*S(theta3)*S(alpha2) + d3*C(alpha2) + d2 + d4*(-C(theta3)*S(alpha2)*S(alpha3) + C(alpha2)*C(alpha3)));
           a = -k2;
           b = k1;
           c = (z - k4)/S(alpha1);
           theta21 = atan2(b, a) - atan2((a^2 + b^2 - c^2)^0.5, c);
           theta22 = atan2(b, a) + atan2((a^2 + b^2 - c^2)^0.5, c);
           sol(i, 2) = theta21;
           sol(i + 2, 2) = theta22;
       else
           realindex(i) = 0;
           realindex(i+2) = 0;
       end
    end
    
elseif S(alpha1) == 0
    a = -d4*C(alpha1)*S(alpha2)*S(alpha3);
    b = a3*C(alpha1)*S(alpha2);
    c = z - (C(alpha1)*(d3*C(alpha2) + d2 + d4*C(alpha2)*C(alpha3)));
    theta31 = atan2(b, a) - atan2((a^2 + b^2 - c^2)^0.5, c);
    theta32 = atan2(b, a) + atan2((a^2 + b^2 - c^2)^0.5, c);
    sol(1, 3) = theta31;
    sol(2, 3) = theta32;
    
    for i =1:2
        theta3 = sol(i, 3);
       if isreal(theta3)
           sol(i + 2, 3) = theta3;
           k1 = a2 + d4*S(theta3)*S(alpha3) + a3*C(theta3);
           k2 = -C(alpha2)*(-d4*C(theta3)*S(alpha3)+a3*S(theta3)) + S(alpha2)*(d3 + d4*C(alpha3));
           k3 = a1^2 + d2^2 + a2^2 + d3^2 + a3^2 + d4^2 + 2*d2*d3*C(alpha2) + 2*d2*d4*C(alpha2)*C(alpha3) + 2*d3*d4*C(alpha3) + C(theta3)*(2*a2*a3 - 2*d2*d4*S(alpha2)*S(alpha3)) + S(theta3)*(2*a3*d2*S(alpha2) + 2*a2*d4*S(alpha3));
           a = k1;
           b = k2;
           c = (r - k3)/(2*a1);
           theta21 = atan2(b, a) - atan2((a^2 + b^2 - c^2)^0.5, c);
           theta22 = atan2(b, a) + atan2((a^2 + b^2 - c^2)^0.5, c);
           sol(i, 2) = theta21;
           sol(i + 2, 2) = theta22;
       else
           realindex(i) = 0;
           realindex(i+2) = 0;
       end
    end
else
    a = a1^4*sin(alpha1)^2 + a2^4*sin(alpha1)^2 + a3^4*sin(alpha1)^2 + d2^4*sin(alpha1)^2 + d3^4*sin(alpha1)^2 + d4^4*sin(alpha1)^2 + r^2*sin(alpha1)^2 + 4*a1^2*z^2 + 4*a1^2*d2^2*cos(alpha1)^2 - 2*a1^2*a2^2*sin(alpha1)^2 - 2*a1^2*a3^2*sin(alpha1)^2 + 6*a2^2*a3^2*sin(alpha1)^2 + 2*a1^2*d2^2*sin(alpha1)^2 + 2*a1^2*d3^2*sin(alpha1)^2 + 2*a2^2*d2^2*sin(alpha1)^2 + 2*a1^2*d4^2*sin(alpha1)^2 + 2*a2^2*d3^2*sin(alpha1)^2 + 2*a3^2*d2^2*sin(alpha1)^2 + 2*a2^2*d4^2*sin(alpha1)^2 + 2*a3^2*d3^2*sin(alpha1)^2 + 2*a3^2*d4^2*sin(alpha1)^2 + 2*d2^2*d3^2*sin(alpha1)^2 + 2*d2^2*d4^2*sin(alpha1)^2 + 2*d3^2*d4^2*sin(alpha1)^2 - 4*a2*a3^3*sin(alpha1)^2 - 4*a2^3*a3*sin(alpha1)^2 - 2*a1^2*r*sin(alpha1)^2 - 2*a2^2*r*sin(alpha1)^2 - 2*a3^2*r*sin(alpha1)^2 - 2*d2^2*r*sin(alpha1)^2 - 2*d3^2*r*sin(alpha1)^2 - 2*d4^2*r*sin(alpha1)^2 + 4*a1^2*a2*a3*sin(alpha1)^2 - 4*a2*a3*d2^2*sin(alpha1)^2 - 4*a2*a3*d3^2*sin(alpha1)^2 - 4*a2*a3*d4^2*sin(alpha1)^2 + 4*a1^2*d3^2*cos(alpha1)^2*cos(alpha2)^2 + 4*d2^2*d3^2*cos(alpha2)^2*sin(alpha1)^2 + 4*d3^2*d4^2*cos(alpha3)^2*sin(alpha1)^2 - 4*a1^2*d3^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2*d3^3*cos(alpha2)*sin(alpha1)^2 + 4*d2^3*d3*cos(alpha2)*sin(alpha1)^2 + 4*d3*d4^3*cos(alpha3)*sin(alpha1)^2 + 4*d3^3*d4*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d2*z*cos(alpha1) + 4*a2*a3*r*sin(alpha1)^2 + 4*d2*d4^3*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*d2^3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3)^2 + 4*d2^2*d4^2*cos(alpha2)^2*cos(alpha3)^2*sin(alpha1)^2 + 4*d2*d4^3*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*d2^3*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a1^2*d4^2*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha3)^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2^2*d4^2*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 8*a1^2*d3*z*cos(alpha1)*cos(alpha2) - 4*d2*d3*r*cos(alpha2)*sin(alpha1)^2 - 4*d3*d4*r*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d2*d3*cos(alpha1)^2*cos(alpha2) + 4*a1^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a2^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a3^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*d2*d3*d4^2*cos(alpha2)*sin(alpha1)^2 + 4*d2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*d2*d3*d4^2*cos(alpha2)*cos(alpha3)^2*sin(alpha1)^2 + 8*d2^2*d3*d4*cos(alpha2)^2*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2)^2 - 8*a1^2*d4*z*cos(alpha1)*cos(alpha2)*cos(alpha3) - 4*d2*d4*r*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d4*z*cos(alpha1)*sin(alpha2)*sin(alpha3) - 4*d2*d4*r*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a1^2*d2*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3) + 4*a1^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 12*d2*d3^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d2*d4*cos(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a1^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a2^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a3^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*d2*d3^2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*a2*a3*d2*d3*cos(alpha2)*sin(alpha1)^2 - 8*a2*a3*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3) + 8*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2)*sin(alpha3) + 8*a1^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*d2^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)*sin(alpha2)*sin(alpha3) + 8*a1^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*d2^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*d2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*a2*a3*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a2*a3*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3);
    b = 8*a3*d2^3*sin(alpha1)^2*sin(alpha2) + 8*a3^3*d2*sin(alpha1)^2*sin(alpha2) + 8*a2*d4^3*sin(alpha1)^2*sin(alpha3) + 8*a2^3*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*z*cos(alpha1)*sin(alpha2) - 8*a3*d2*r*sin(alpha1)^2*sin(alpha2) - 8*a2*d4*r*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d2*cos(alpha1)^2*sin(alpha2) + 8*a1^2*a3*d2*sin(alpha1)^2*sin(alpha2) - 16*a2*a3^2*d2*sin(alpha1)^2*sin(alpha2) + 8*a2^2*a3*d2*sin(alpha1)^2*sin(alpha2) - 8*a1^2*a2*d4*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a2*a3^2*d4*sin(alpha1)^2*sin(alpha3) - 16*a2^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d3^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d2^2*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d4^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d3^2*d4*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3) - 16*a1^2*a3*d4*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3) + 16*a2*d2*d4^2*sin(alpha1)^2*sin(alpha2)*sin(alpha3)^2 + 16*a3*d2^2*d4*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3) + 16*a1^2*a3*d3*cos(alpha1)^2*cos(alpha2)*sin(alpha2) + 16*a1^2*a3*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a3*d2^2*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2) + 16*a1^2*a3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2);
    c = 2*a1^4*sin(alpha1)^2 + 2*a2^4*sin(alpha1)^2 + 2*a3^4*sin(alpha1)^2 + 2*d2^4*sin(alpha1)^2 + 2*d3^4*sin(alpha1)^2 + 2*d4^4*sin(alpha1)^2 + 2*r^2*sin(alpha1)^2 + 8*a1^2*z^2 + 8*a1^2*d2^2*cos(alpha1)^2 - 4*a1^2*a2^2*sin(alpha1)^2 + 12*a1^2*a3^2*sin(alpha1)^2 - 4*a2^2*a3^2*sin(alpha1)^2 + 4*a1^2*d2^2*sin(alpha1)^2 + 4*a1^2*d3^2*sin(alpha1)^2 + 4*a2^2*d2^2*sin(alpha1)^2 + 4*a1^2*d4^2*sin(alpha1)^2 + 4*a2^2*d3^2*sin(alpha1)^2 + 4*a3^2*d2^2*sin(alpha1)^2 + 4*a2^2*d4^2*sin(alpha1)^2 + 4*a3^2*d3^2*sin(alpha1)^2 + 4*a3^2*d4^2*sin(alpha1)^2 + 4*d2^2*d3^2*sin(alpha1)^2 + 4*d2^2*d4^2*sin(alpha1)^2 + 4*d3^2*d4^2*sin(alpha1)^2 - 4*a1^2*r*sin(alpha1)^2 - 4*a2^2*r*sin(alpha1)^2 - 4*a3^2*r*sin(alpha1)^2 - 4*d2^2*r*sin(alpha1)^2 - 4*d3^2*r*sin(alpha1)^2 - 4*d4^2*r*sin(alpha1)^2 + 8*a1^2*d3^2*cos(alpha1)^2*cos(alpha2)^2 + 16*a1^2*a3^2*cos(alpha1)^2*sin(alpha2)^2 - 16*a1^2*a3^2*cos(alpha2)^2*sin(alpha1)^2 + 8*d2^2*d3^2*cos(alpha2)^2*sin(alpha1)^2 + 8*d3^2*d4^2*cos(alpha3)^2*sin(alpha1)^2 - 8*a1^2*d3^2*sin(alpha1)^2*sin(alpha2)^2 + 16*a3^2*d2^2*sin(alpha1)^2*sin(alpha2)^2 - 16*a1^2*d4^2*sin(alpha1)^2*sin(alpha3)^2 + 16*a2^2*d4^2*sin(alpha1)^2*sin(alpha3)^2 + 8*d2*d3^3*cos(alpha2)*sin(alpha1)^2 + 8*d2^3*d3*cos(alpha2)*sin(alpha1)^2 + 8*d3*d4^3*cos(alpha3)*sin(alpha1)^2 + 8*d3^3*d4*cos(alpha3)*sin(alpha1)^2 - 16*a1^2*d2*z*cos(alpha1) + 8*d2*d4^3*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*d2^3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3)^2 + 8*d2^2*d4^2*cos(alpha2)^2*cos(alpha3)^2*sin(alpha1)^2 - 8*a1^2*d4^2*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 + 8*a1^2*d4^2*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3)^2 - 8*a1^2*d4^2*cos(alpha3)^2*sin(alpha1)^2*sin(alpha2)^2 - 8*d2^2*d4^2*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 16*a1^2*d3*z*cos(alpha1)*cos(alpha2) - 8*d2*d3*r*cos(alpha2)*sin(alpha1)^2 - 8*d3*d4*r*cos(alpha3)*sin(alpha1)^2 + 16*a1^2*d2*d3*cos(alpha1)^2*cos(alpha2) + 8*a1^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a2^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a3^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a3^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*d2*d3*d4^2*cos(alpha2)*sin(alpha1)^2 + 8*d2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 16*d2*d3*d4^2*cos(alpha2)*cos(alpha3)^2*sin(alpha1)^2 + 16*d2^2*d3*d4*cos(alpha2)^2*cos(alpha3)*sin(alpha1)^2 - 16*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2)^2 - 16*a1^2*d4*z*cos(alpha1)*cos(alpha2)*cos(alpha3) - 8*d2*d4*r*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 16*a1^2*d2*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3) + 8*a1^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a2^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a3^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 24*d2*d3^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 16*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3) + 48*a2*a3*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3);
    d = 8*a3*d2^3*sin(alpha1)^2*sin(alpha2) + 8*a3^3*d2*sin(alpha1)^2*sin(alpha2) + 8*a2*d4^3*sin(alpha1)^2*sin(alpha3) + 8*a2^3*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*z*cos(alpha1)*sin(alpha2) - 8*a3*d2*r*sin(alpha1)^2*sin(alpha2) - 8*a2*d4*r*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d2*cos(alpha1)^2*sin(alpha2) + 8*a1^2*a3*d2*sin(alpha1)^2*sin(alpha2) + 16*a2*a3^2*d2*sin(alpha1)^2*sin(alpha2) + 8*a2^2*a3*d2*sin(alpha1)^2*sin(alpha2) - 8*a1^2*a2*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a2*a3^2*d4*sin(alpha1)^2*sin(alpha3) + 16*a2^2*a3*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d3^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d2^2*d4*sin(alpha1)^2*sin(alpha3) + 8*a3*d2*d4^2*sin(alpha1)^2*sin(alpha2) + 8*a2*d3^2*d4*sin(alpha1)^2*sin(alpha3) - 16*a1^2*a3*d4*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3) - 16*a2*d2*d4^2*sin(alpha1)^2*sin(alpha2)*sin(alpha3)^2 - 16*a3*d2^2*d4*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3) + 16*a1^2*a3*d3*cos(alpha1)^2*cos(alpha2)*sin(alpha2) + 16*a1^2*a3*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a3*d2^2*d3*cos(alpha2)*sin(alpha1)^2*sin(alpha2) + 16*a2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a1^2*a3*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2) + 16*a1^2*a3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2) + 16*a2*d2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha3) + 16*a3*d2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2);
    e = a1^4*sin(alpha1)^2 + a2^4*sin(alpha1)^2 + a3^4*sin(alpha1)^2 + d2^4*sin(alpha1)^2 + d3^4*sin(alpha1)^2 + d4^4*sin(alpha1)^2 + r^2*sin(alpha1)^2 + 4*a1^2*z^2 + 4*a1^2*d2^2*cos(alpha1)^2 - 2*a1^2*a2^2*sin(alpha1)^2 - 2*a1^2*a3^2*sin(alpha1)^2 + 6*a2^2*a3^2*sin(alpha1)^2 + 2*a1^2*d2^2*sin(alpha1)^2 + 2*a1^2*d3^2*sin(alpha1)^2 + 2*a2^2*d2^2*sin(alpha1)^2 + 2*a1^2*d4^2*sin(alpha1)^2 + 2*a2^2*d3^2*sin(alpha1)^2 + 2*a3^2*d2^2*sin(alpha1)^2 + 2*a2^2*d4^2*sin(alpha1)^2 + 2*a3^2*d3^2*sin(alpha1)^2 + 2*a3^2*d4^2*sin(alpha1)^2 + 2*d2^2*d3^2*sin(alpha1)^2 + 2*d2^2*d4^2*sin(alpha1)^2 + 2*d3^2*d4^2*sin(alpha1)^2 + 4*a2*a3^3*sin(alpha1)^2 + 4*a2^3*a3*sin(alpha1)^2 - 2*a1^2*r*sin(alpha1)^2 - 2*a2^2*r*sin(alpha1)^2 - 2*a3^2*r*sin(alpha1)^2 - 2*d2^2*r*sin(alpha1)^2 - 2*d3^2*r*sin(alpha1)^2 - 2*d4^2*r*sin(alpha1)^2 - 4*a1^2*a2*a3*sin(alpha1)^2 + 4*a2*a3*d2^2*sin(alpha1)^2 + 4*a2*a3*d3^2*sin(alpha1)^2 + 4*a2*a3*d4^2*sin(alpha1)^2 + 4*a1^2*d3^2*cos(alpha1)^2*cos(alpha2)^2 + 4*d2^2*d3^2*cos(alpha2)^2*sin(alpha1)^2 + 4*d3^2*d4^2*cos(alpha3)^2*sin(alpha1)^2 - 4*a1^2*d3^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2*d3^3*cos(alpha2)*sin(alpha1)^2 + 4*d2^3*d3*cos(alpha2)*sin(alpha1)^2 + 4*d3*d4^3*cos(alpha3)*sin(alpha1)^2 + 4*d3^3*d4*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d2*z*cos(alpha1) - 4*a2*a3*r*sin(alpha1)^2 + 4*d2*d4^3*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*d2^3*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3)^2 + 4*d2^2*d4^2*cos(alpha2)^2*cos(alpha3)^2*sin(alpha1)^2 - 4*d2*d4^3*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*d2^3*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 4*a1^2*d4^2*cos(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha2)^2*sin(alpha1)^2*sin(alpha3)^2 - 4*a1^2*d4^2*cos(alpha3)^2*sin(alpha1)^2*sin(alpha2)^2 + 4*d2^2*d4^2*sin(alpha1)^2*sin(alpha2)^2*sin(alpha3)^2 - 8*a1^2*d3*z*cos(alpha1)*cos(alpha2) - 4*d2*d3*r*cos(alpha2)*sin(alpha1)^2 - 4*d3*d4*r*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d2*d3*cos(alpha1)^2*cos(alpha2) + 4*a1^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a2^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a3^2*d2*d3*cos(alpha2)*sin(alpha1)^2 + 4*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 4*d2*d3*d4^2*cos(alpha2)*sin(alpha1)^2 + 4*d2^2*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*d2*d3*d4^2*cos(alpha2)*cos(alpha3)^2*sin(alpha1)^2 + 8*d2^2*d3*d4*cos(alpha2)^2*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d3*d4*cos(alpha3)*sin(alpha1)^2*sin(alpha2)^2 - 8*a1^2*d4*z*cos(alpha1)*cos(alpha2)*cos(alpha3) - 4*d2*d4*r*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d4*z*cos(alpha1)*sin(alpha2)*sin(alpha3) + 4*d2*d4*r*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a1^2*d2*d4*cos(alpha1)^2*cos(alpha2)*cos(alpha3) + 4*a1^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a2^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 4*a3^2*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 + 12*d2*d3^2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a1^2*d2*d4*cos(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*a1^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*a2^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*a3^2*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 4*d2*d3^2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a2*a3*d2*d3*cos(alpha2)*sin(alpha1)^2 + 8*a2*a3*d3*d4*cos(alpha3)*sin(alpha1)^2 + 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)^2*cos(alpha3) - 8*a1^2*d4^2*cos(alpha1)^2*cos(alpha2)*cos(alpha3)*sin(alpha2)*sin(alpha3) - 8*a1^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*d2^2*d4^2*cos(alpha2)*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*a1^2*d3*d4*cos(alpha1)^2*cos(alpha2)*sin(alpha2)*sin(alpha3) - 8*a1^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*d2^2*d3*d4*cos(alpha2)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) - 8*d2*d3*d4^2*cos(alpha3)*sin(alpha1)^2*sin(alpha2)*sin(alpha3) + 8*a2*a3*d2*d4*cos(alpha2)*cos(alpha3)*sin(alpha1)^2 - 8*a2*a3*d2*d4*sin(alpha1)^2*sin(alpha2)*sin(alpha3);
    
    co = [e, d, c, b, a];
    sol(1:4, 3) = 2*atan(quarticsolver(co));
    %syms u
    %sol(1:4, 3) = 2*atan(solve(a*u^4 + b*u^3 + c*u^2 + d*u + e));
    
    for i = 1:4
       theta3 = sol(i,  3);
       if isreal(theta3)
           k1 = a2 + d4*S(theta3)*S(alpha3) + a3*C(theta3);
           k2 = -C(alpha2)*(-d4*C(theta3)*S(alpha3)+a3*S(theta3)) + S(alpha2)*(d3 + d4*C(alpha3));
           k3 = a1^2 + d2^2 + a2^2 + d3^2 + a3^2 + d4^2 + 2*d2*d3*C(alpha2) + 2*d2*d4*C(alpha2)*C(alpha3) + 2*d3*d4*C(alpha3) + C(theta3)*(2*a2*a3 - 2*d2*d4*S(alpha2)*S(alpha3)) + S(theta3)*(2*a3*d2*S(alpha2) + 2*a2*d4*S(alpha3));
           k4 = C(alpha1)*(a3*S(theta3)*S(alpha2) + d3*C(alpha2) + d2 + d4*(-C(theta3)*S(alpha2)*S(alpha3) + C(alpha2)*C(alpha3)));
           theta21 = atan2(k1*(z - k4)/S(alpha1) + k2*(r - k3)/(2*a1), k1*(r - k3)/(2*a1) - k2*(z - k4)/S(alpha1));
           sol(i, 2) = theta21;
       else
           realindex(i) = 0;
       end
    end
    
end

%% theta1

for i = 1:4
   ir = isreal(sol(i, 2)) + isreal(sol(i, 3));
   if ir == 2
       theta3 = sol(i, 3);
       theta2 = sol(i, 2);
       f1 = d4*S(theta3)*S(alpha3) + a3*C(theta3);
       f2 = -d4*C(theta3)*S(alpha3) + a3*S(theta3);
       f3 = d4*C(alpha3) + d3;
       g1 = C(theta2)*(a2 + f1) + S(theta2)*(-C(alpha2)*f2 + S(alpha2)*f3) + a1;
       g2 = -S(theta2)*C(alpha1)*(a2 + f1) + C(theta2)*C(alpha1)*(-C(alpha2)*f2 + S(alpha2)*f3) + S(alpha1)*(S(alpha2)*f2 + C(alpha2)*f3 + d2);
       theta11 = atan2(g1*y + g2*x, g1*x - g2*y);
       sol(i, 1) = theta11;
   else
       realindex(i) = 0;
   end
    
end

%% theta4, theta5 & theta6

for i = 1:4
   ir = isreal(sol(i, 1)) + isreal(sol(i, 2)) + isreal(sol(i, 3));
    if ir == 3
        Rd = T(1:3, 1:3);
        th123 = sol(i, 1:3);
        R = R456(DH, Rd, th123);
        sol(i+4, :) = sol(i, :);
        
%         % ZXZ Euler Angles
%         theta51 = atan2((R(1, 3)^2 + R(2, 3)^2)^0.5, R(3, 3));
%         theta52 = atan2(-(R(1, 3)^2 + R(2, 3)^2)^0.5, R(3, 3));
%         if S(theta51) ~= 0
%             theta41 = atan2(R(1, 3)/S(theta51), -R(2, 3)/S(theta51));
%             theta42 = atan2(R(1, 3)/S(theta52), -R(2, 3)/S(theta52));
%             theta61 = atan2(R(3, 1)/S(theta51), R(3, 2)/S(theta51));
%             theta62 = atan2(R(3, 1)/S(theta52), R(3, 2)/S(theta52));
%         else
%             theta41 = 0;
%             theta42 = theta41;
%             theta61 = C(theta51) * atan2(R(2, 1), R(1, 1));
%             theta62 = theta61;
%         end
        
        % Modified for alpha4 = +/-pi/2, alpha5 = +/-pi/2, alpha6 = 0
        theta51 = atan2((R(3, 1)^2 + R(3, 2)^2)^0.5, -R(3, 3)/(S(alpha4)*S(alpha5)));
        theta52 = atan2(-(R(3, 1)^2 + R(3, 2)^2)^0.5, -R(3, 3)/(S(alpha4)*S(alpha5)));
        if S(theta51) ~= 0
            theta41 = atan2(R(2, 3)/(S(alpha5)*S(theta51)), R(1, 3)/(S(alpha5)*S(theta51)));
            theta42 = atan2(R(2, 3)/(S(alpha5)*S(theta52)), R(1, 3)/(S(alpha5)*S(theta52)));
            theta61 = atan2(-R(3, 2)/(S(alpha4)*S(theta51)), R(3, 1)/(S(alpha4)*S(theta51)));
            theta62 = atan2(-R(3, 2)/(S(alpha4)*S(theta52)), R(3, 1)/(S(alpha4)*S(theta52)));
        elseif theta51 == 0
            theta41 = 0;
            theta42 = theta41;
            theta61 = atan2(-R(1, 2), R(1, 1));
            theta62 = theta61;
        else
            theta41 = 0;
            theta42 = theta41;
            theta61 = atan2(R(1, 2), -R(1, 1));
            theta62 = theta61;
        end
        
        sol(i, 5) = theta51;
        sol(i, 4) = theta41;
        sol(i, 6) = theta61;
        sol(i+4, 5) = theta52;
        sol(i+4, 4) = theta42;
        sol(i+4, 6) = theta62;
        
    else
        realindex(i) = 0;
        realindex(i+4) = 0;
    end
    
end

nsol = sum(realindex);

if nsol < 8
   sol(1:nsol, :) = sol(realindex == 1, :);
   sol(nsol+1:end, :) = 0;
   realindex(1:nsol) = 1;
   realindex(nsol+1:8) = 0;
end

end

%% sub-functions

function sol = quarticsolver(coeffs)

e = coeffs(1);
d = coeffs(2);
c = coeffs(3);
b = coeffs(4);
a = coeffs(5);

p = (8*a*c-3*b^2)/(8*a^2);
q = (b^3-4*a*b*c+8*a^2*d)/(8*a^3);
delta0 = c^2-3*b*d+12*a*e;
delta1 = 2*c^3-9*b*c*d+27*b^2*e+27*a*d^2-72*a*c*e;
Q = ((delta1+(delta1^2-4*delta0^3)^0.5)/2)^(1/3);
S = 0.5*(-2/3*p+1/(3*a)*(Q+delta0/Q))^0.5;

x1 = -b/(4*a)-S+0.5*(-4*S^2-2*p+q/S)^0.5;
x2 = -b/(4*a)-S-0.5*(-4*S^2-2*p+q/S)^0.5;
x3 = -b/(4*a)+S+0.5*(-4*S^2-2*p-q/S)^0.5;
x4 = -b/(4*a)+S-0.5*(-4*S^2-2*p-q/S)^0.5;
sol = [x1; x2; x3; x4];

% noncomplex solution correction threshold
isol1 = imag(sol);
isol2 = abs(isol1) < 1e-10 & isol1 ~= 0;
sol(isol2) = real(sol(isol2));

% nozero real parts correction threshold
rsol1 = real(sol);
rsol2 = abs(rsol1) < 1e-10 & rsol1 ~= 0;
sol(rsol2) = sol(rsol2) - real(sol(rsol2));
end

function y = R456(DH, Rd, th123)

R = eye(3);

for i = 1:3
    alpha = DH(i, 1);
    theta = th123(i);
    R = R * [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha);
            sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha);
            0, sin(alpha), cos(alpha)];
end

y = transpose(R) * Rd;

end
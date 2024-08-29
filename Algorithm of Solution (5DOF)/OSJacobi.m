function J = OSJacobi(DH)
% Jacobi computation method by David E. Orin and William W. Schrader
nd = size(DH, 1);
z = [0 0 1]';
U = zeros(3, 3, nd+2);
gamma = zeros(3, nd);

r = zeros(3, nd+2);
beta = zeros(3, nd);

U(:, :, nd+2) = eye(3);
r(:, nd+2) = zeros(3, 1);

T = zeros(4, 4, nd+1);
T(:, :, nd+1) = eye(4);
T(4, 4, :) = 1;
R = T(1:3, 1:3, :);
p = zeros(3, nd+1);
RR = ones(3);

for i = 1:nd
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
   p(:, i) = T(1:3, 4, i);
   RR = RR*R(:, :, i);
end


for i = nd+1:-1:1
    U(:, :, i) = U(:, :, i+1)*R(:, :, i)';
    r(:, i) = r(:, i+1) - U(:, :, i+1)*(-R(:, :, i)'*p(:, i));
end

for i = i:nd
   gamma(:, i) =  U(:, :, i)*z;
   beta(:, i) = cross(gamma(:, i), r(:, i));
end

J = [beta; gamma];
RRR = zeros(6, 6);
RRR(1:3, 1:3) = RR;
RRR(4:6, 4:6) = RR;
J = RRR*J;

end
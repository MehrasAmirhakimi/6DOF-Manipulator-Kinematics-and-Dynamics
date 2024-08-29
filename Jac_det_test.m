%J = rand(6, 6, 1000);
W = zeros(1000, 1);
for i =1:1000
    W(i) = abs(det(J(:, :, i)));
    %W(i) = sqrt(det(J(:, :, i)*J(:, :, i)'));
end
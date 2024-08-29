n_path = size(J_path, 3);
ns = size(J_path, 4);
W = zeros(ns, n_path);

for i =1:ns
    for j =1:n_path
        J = J_path(:, :, j, i);
        W(i, j) = det(J*J'); 
    end
end
function d = sdm(sol1, sols)

d = zeros(size(sols));
nsol = size(sols, 1);
for i = 1:nsol
    d(i, :) = sol1 - sols(i, :);
end

d = d.^2;
d = sum(d, 2);

end
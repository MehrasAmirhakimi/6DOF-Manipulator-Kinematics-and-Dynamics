function thdot_path = ThdotCalc(J_path, V)

thdot_path = zeros(8, 6);
for i = 1:8
    thdot_path(i, :) = (J_path(:, :, 1, i)\V)';
end

end
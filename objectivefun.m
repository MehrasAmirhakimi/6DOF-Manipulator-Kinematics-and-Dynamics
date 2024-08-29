function obj = objectivefun(ppop, th_path, J_path, thdot_path, dt)

npop = size(ppop, 1);
obj = zeros(npop, 3);
npath = size(ppop, 2); % cromosome length

thpoint = zeros(6, npath);
thdotpoint = zeros(6, npath);

delthpoint = zeros(6, npath-1);
delthdotpoint = zeros(6, npath-1);

W = zeros(npop, npath);

for i = 1:npop
    
    
    for j = 1:npath
       thpoint(:, j) = th_path(ppop(i, j), :, j);
       thdotpoint(:, j) = thdot_path(ppop(i, j), :, j);
       J = J_path(:, :, j, ppop(i, j));
       W(i, j) = sqrt(det(J*J'));
    end
    obj(i, 1) = min(W(i, :)); % Objective 1: Jacobian Determinant
    
    
    for j = 1:npath-1
       delthpoint(:, j) = thpoint(:, j+1) - thpoint(:, j);
       delthdotpoint(:, j) = (thdotpoint(:, j+1) - thdotpoint(:, j))/dt;
    end
    
    delthpoint = sum(abs(delthpoint), 2);
    obj(i, 2) = sum([4; 6; 5; 3; 2; 1] .* delthpoint); % Objective 2: joint angel distances
    
    delthdotpoint = max(delthdotpoint, [], 2);
    obj(i, 3) = sum([4; 6; 5; 3; 2; 1] .* delthdotpoint); % Objective 3: joint angel acceleration
    
    
end


end
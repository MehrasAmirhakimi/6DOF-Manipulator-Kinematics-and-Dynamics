function obj = objectivefun(ppop, th_path, thdot_path, J_path, dt)
% global adebug
npop = size(ppop, 1);
obj = zeros(npop, 3);
npath = size(ppop, 2);
nd = size(th_path, 2);
thpoint = zeros(nd, npath);
thdotpoint = zeros(nd, npath);

delthpoint = zeros(nd, npath-1);
delthdotpoint = zeros(nd, npath-1);

W = zeros(npop, npath);

for i = 1:npop
    
    
    for j = 1:npath
        thpoint(:, j) = th_path(ppop(i, j), :, j)';
        thdotpoint(:, j) = thdot_path(ppop(i, j), :, j);
        J = J_path(:, :, j, ppop(i, j));
        W(i, j) = sqrt(abs(det(J*J')));
    end
    obj(i, 1) = min(W(i, :))*10^6; % Objective 1: Jacobian Determinant
    
    
    for j = 1:npath-1
       delthpoint(:, j) = thpoint(:, j+1) - thpoint(:, j);
       delthdotpoint(:, j) = (thdotpoint(:, j+1) - thdotpoint(:, j))/dt;
    end
    
    delthpoint = sum(abs(delthpoint), 2);
    obj(i, 2) = sum([4; 6; 5; 3; 2] .* delthpoint); % Objective 2: joint angel distances
    
    delthdotpoint = max(delthdotpoint, [], 2);
    obj(i, 3) = sum([4; 6; 5; 3; 2] .* delthdotpoint); % Objective 3: joint angel acceleration
    
    
end


end
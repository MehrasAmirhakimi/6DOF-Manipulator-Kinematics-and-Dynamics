function path = optimpath(th_path, realindex, thdot_path, J_path, dt)

nsol = sum(realindex, 1);
if any(nsol == 0)
   [~, column] = find(nsol == 0);
   formatspec = 'points';
   for iz = 1:numel(column)
       formatspec = [formatspec ' %d'];
   end
   
   formatspec = [formatspec ' are totally non-real solutions \n'];
   fprintf(formatspec, column);
else
    npath = size(th_path, 3);
    m = [1, 0, 0]; % minimization problem: 0 or maximization problem: 1
    id = repmat([3; 1; 8], [1, npath]);
    id(1, nsol == 4) = 2; % needs review
    id(3, :) = nsol; % needs review

    npop = 100;
    ngen = 500;
    [ppop, objfrontcrowding] = funBinaryNSGAII(npop, ngen, id, m, th_path, thdot_path, J_path, dt);


    objs = objfrontcrowding(:, 1:3);
    fronts = objfrontcrowding(:, 4);

    ppop = ppop(fronts == 1, :);
    objs = objs(fronts == 1);

    objs(:, 1) = 1./objs(:, 1);
    objs = sum(objs.^2, 2);
    [~, pathi] = min(objs);

    path = ppop(pathi, :);
end



end
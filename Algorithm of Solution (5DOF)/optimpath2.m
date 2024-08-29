function path = optimpath2(th_path, realindex, limitcheck, thdot_path, J_path, dt)

nsol = sum(realindex, 1);
ns = size(realindex, 1);
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
    
    if ns == 4
        id = repmat([2; 1; ns], [1, npath]);
        id(1, nsol == 2) = 1;
        id(3, :) = nsol; % needs review
    else
        % ns should be 8
        id = repmat([3; 1; ns], [1, npath]);
        id(1, nsol == 4) = 2;
        id(3, :) = nsol; % needs review
    end
    

    npop = 200;
    ngen =100;
    [ppop, objfrontcrowding] = funBinaryNSGAII2(npop, ngen, id, m, th_path, limitcheck, thdot_path, J_path, dt);


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
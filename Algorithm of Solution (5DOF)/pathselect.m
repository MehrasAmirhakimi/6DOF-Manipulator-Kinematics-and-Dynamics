function paths = pathselect(th_path, realindex)

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
    paths = zeros(nsol(1), npath);
    
    for i = 1:nsol(1)
        paths(i, 1) = i;
        for j = 2:npath
            point1 = th_path(paths(i,j-1), :, j-1);
            point1 = repmat(point1, nsol(j), 1);
            point2 = th_path(1:nsol(j), :, j);
            delta = abs(point2 - point1);
            delta(delta > pi) = 2*pi - delta(delta > pi);
            delta = sum(delta.^2, 2);
            [~, m] = min(delta);
            paths(i, j) = m;
        end
    end
    
    
end



end
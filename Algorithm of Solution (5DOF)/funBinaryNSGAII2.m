function [ppop, objfrontcrowding] = funBinaryNSGAII2(npop, ngen, id, m, th_path, limitcheck, thdot_path, J_path, dt)
%% GA parameters
global ginitpop
ncr = sum(id(1, :)); % each cromosome length
pc = 0.8; % probability of crossover
pm = 0.2; % probability of mutation
sdu = [0.7, 0.15, 0.15];
mu = 0.4;

parse = @(x) parsepop(x, id);
docrossover = @(x1, x2) crossover(x1, x2, sdu);
domutation = @(x) mutation(x, mu);
costfunction = @(x) objectivefun(x, th_path, thdot_path, J_path, dt); % this function has 3 outputs

%% Create initial population

initpop = zeros(npop, ncr + numel(m) + 2);
initpop(:, 1 : ncr) = randi([0 1], [npop, ncr]);
ppop = parse(initpop);
initpop(:, ncr + 1 : ncr + numel(m)) = costfunction(ppop);
f = front(initpop(:, ncr + 1 : ncr + numel(m)), m);
fmax = max(f(:, 2));
ippop = checklimits(ppop, limitcheck);
f(ippop == 0, 2) = fmax + 1;
initpop(:, ncr + numel(m) + 1) = f(:, 2);
cd = crowdingdistance(initpop(:, ncr + 1 : ncr + numel(m)), f, m);
initpop(:, ncr + numel(m) + 2) = cd;


%% main loop

%figure

for i = 1:ngen

    % do crossover
    
    crosspop = zeros(size(initpop));
    jx = 0;
    for ix = 1:npop/2
        a = rand;
        if a < pc
            jx = jx + 2;
            c1 = binaryts(initpop(:, end-1:end));
            c2 = binaryts(initpop(:, end-1:end));
            x1 = initpop(c1, 1:ncr);
            x2 = initpop(c2, 1:ncr);
            [y1, y2] = docrossover(x1, x2);
            crosspop(jx-1, 1:ncr) = y1;
            crosspop(jx, 1:ncr) = y2;
        end
    end
    crosspop(jx+1:end, :)=[];
    pcrosspop = parse(crosspop);
    crosspop(:, ncr + 1 : ncr + numel(m)) = costfunction(pcrosspop);
    
    % do mutation
    
    mutpop = zeros(size(initpop));
    jm = 0;
    for im = 1:npop
        b = rand;
        if b < pm
            jm = jm+1;
            c = binaryts(initpop(:, end-1:end));
            x = initpop(c, 1:ncr);
            y = domutation(x);
            mutpop(jm, 1:ncr) = y;
        end
    end
    mutpop(jm+1:end, :)=[];
    pmutpop = parse(mutpop);
    mutpop(:, ncr + 1 : ncr + numel(m)) = costfunction(pmutpop);
    
    % going to next generation
    
    pop = [initpop; crosspop; mutpop];
    
    f = front(pop(:, ncr + 1 : ncr + numel(m)), m);
    pop(:, ncr + numel(m) + 1) = f(:, 2);
    
    cd = crowdingdistance(pop(:, ncr + 1 : ncr + numel(m)), f, m);
    pop(:, ncr + numel(m) + 2) = cd;
    
    nf = max(f(:, 2));
    
    ppop = parse(pop);
    ippop = checklimits(ppop, limitcheck);
    f(ippop == 0, 2) = nf + 1;
    
    n_front = zeros(nf, 1);
    
    for ii = 1:nf
        
        n_front(ii) = sum(f(:, 2) == ii);
        
    end
    
    cn_front = cumsum(n_front);
    lf = find(cn_front >= npop, 1, 'first'); % last front
    
    nr = 0;
    
    if cn_front(lf) > npop
        if lf == 1
            nr = npop;
        else
            nr = npop - cn_front(lf-1); % number of remaining cromosomes
        end
        lastfront = f(f(:, 2) == lf, 1); % last front numbers
        lfc = pop(lastfront, ncr + numel(m) + 2); % last front crowding distances
        [~, so] = sort(lfc, 'descend');
        lcr = lastfront(so(1:nr)); % best cromosomes of last front
    end
    
    if nr == 0
        lf2 = lf;
    else
        lf2 = lf - 1;
    end
    
    sf = sortrows(f, 2); % sorted front
    lc = find(sf(:, 2) == lf2, 1, 'last'); % last cromosome on the one before the last front
    initpop(1:npop - nr, :) = pop(sf(1:lc, 1), :);
    if nr ~= 0
        initpop(npop-nr+1:npop, :) = pop(lcr, :);
    end
    f = initpop(npop-nr+1:npop, ncr+numel(m)+1);
    c = initpop(npop-nr+1:npop, ncr+1:ncr+numel(m));
    initpop(npop-nr+1:npop, ncr+numel(m)+2) = crowdingdistance(c, f, m);
    
    % showing the result in each generation
    
    if lf == 1
        n_front1 = npop;
    else
        n_front1 = n_front(1);
    end
    
    xy1 = initpop(1:n_front1, ncr + 1 : ncr + numel(m))';
    ginitpop = initpop;
    xf1 = xy1(1, :);
    yf1 = xy1(2, :);
    zf1 = xy1(3, :);
    
    pause(0.01);
%     plot(xf1, yf1, 'o');
    plot3(xf1, yf1, zf1, 'o');
    fprintf('generation: %g \n', i);
    
end
ppop = parsepop(pop, id);
objfrontcrowding = initpop(:, ncr+1:end);

end

%% sub-functions

function ppop = parsepop(pop, id)

c = cumsum(id(1, :));
c1 = [0, c(1:end-1)] + 1;
c2 = c;
c = [c1', c2'];
nvar = size(id, 2);
ppop = zeros(size(pop, 1), nvar);

for i = 1:nvar
    
    bx = pop(:, c(i, 1):c(i, 2));
    rx = binary2real(bx);
    nb = size(bx, 2);
    rx = rx / (2^nb - 1) * (id(3, i) - id(2, i)) + id(2, i);
    ppop(:, i) = rx;
    
end

end

function rx = binary2real(bx)

l = size(bx, 2);
p1 = l-1:-1:0;
p2 = repmat(p1, [size(bx, 1), 1]);
p3 = 2 .^ p2;
p4 = bx .* p3;
rx = sum(p4, 2);

end

function c = binaryts(fc)

npop = size(fc, 1);
r = randsample(npop, 2);
tfc = fc(r, :);

if tfc(1, 1) == tfc(2, 1)
    [~, ic] = max(tfc(:, 2));
else
    [~, ic] = min(tfc(:, 1));
end

c = r(ic);

end

function [y1, y2] = crossover(x1, x2, sdu)

p = roulettewheel(sdu, 1);

switch p
    case 1
        [y1, y2] = singlepointcrossover(x1, x2);
    case 2
        [y1, y2] = doublepointcrossover(x1, x2);
    case 3
        [y1, y2] = uniformcrossover(x1, x2);
end


end

function [y1, y2] = singlepointcrossover(x1, x2)

cp = randi([1, numel(x1)-1]);

y1 = [x1(1:cp), x2(cp+1:end)];
y2 = [x2(1:cp), x1(cp+1:end)];

end

function [y1, y2] = doublepointcrossover(x1, x2)

cp = randsample(numel(x1)-1, 2);
c1 = min(cp);
c2 = max(cp);

y1 = [x1(1:c1), x2(c1+1:c2), x1(c2+1:end)];
y2 = [x2(1:c1), x1(c1+1:c2), x2(c2+1:end)];

end

function [y1, y2] = uniformcrossover(x1, x2)

mask = randi([0, 1], size(x1));
y1 = mask .* x1 + (1-mask).*x2;
y2 = mask .* x2 + (1-mask) .*x1;

end

function y = mutation(x, mu)

if mu == 0
    nm = 1;
else
    nm = ceil(mu * numel(x));
end

mp = randsample(numel(x), nm);
y = x;
y(mp) = 1 - x(mp);

end

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
    
    delthpoint = abs(delthpoint);
    delthpoint(delthpoint > pi) = 2*pi - delthpoint(delthpoint > pi);
    delthpoint = delthpoint.^2;
    obj(i, 2) = sum(sqrt([1, 1, 1, 1, 1] * delthpoint)); % Objective 2: joint angel distances
    
    delthdotpoint = max(delthdotpoint, [], 2);
    obj(i, 3) = sum([1; 1; 1; 1; 1] .* delthdotpoint); % Objective 3: joint angel acceleration
    
    
end


end

function f = front(c, m)

% c: cost functrions
% f: cost function fronts
% m: min or maximization indicators

n = size(c, 1); % npop
f = zeros(n, 2);
crnum = [1:n]';
f(:, 1) = crnum;
nrc = n; % number of remaining cromosomes
rc = crnum; % remaining cromosomes
i = 0; % front numbering


while nrc > 0 % build each front
    
    i = i + 1;
    f(rc(1), 2) = i;
    
    for j = 2:nrc % pick an individual from whole pop
       
        icr1 = rc(j);
        cr1 = c(icr1, :);
        front = f(f(:, 2) == i, 1);
        nfront = numel(front);
        mcr1 = 0;
        
        for k = 1:nfront % compare it to front members
            
            icr2 = front(k);
            cr2 = c(icr2, :);
            d = dominate(cr1, cr2, m);
            
            switch d
                case -1
                    mcr1 = mcr1 + 0;
                    f(icr2, 2) = i;
                case 0
                    mcr1 = mcr1 + 1;
                    f(icr2, 2) = i;
                case 1
                    mcr1 = mcr1 + 1;
                    f(icr2, 2) = 0;
            end
            
            if mcr1 == nfront
                f(icr1, 2) = i;
            else
                f(icr1, 2) = 0; 
            end
            
        end %
        
    end %
    
    
    rc = f(f(:, 2) == 0, 1);
    nrc = numel(rc);

end %
    
end

function d = dominate(f1, f2, m)

% nm = numel(m);
p1 = (f1 >= f2) == m;
p2 = (f1 > f2) == m;

if all(p1 == 0) || all(p2 == 0)
    d = -1;
elseif all(p1 == 1) || all(p2 == 1)
    d = 1;
else
    d = 0;
end

% sp1 = sum(p1);
% sp2 = sum(p2);
% sp11 = (sp1 - nm / 2) / (nm / 2);
% sp22 = (sp2 - nm / 2) / (nm / 2);
% sp = [sp11, sp22];
% asp1 = abs(sp11);
% asp2 = abs(sp22);
% asp = [asp1, asp2];
% [masp, im] = max(asp);
% d = floor(masp) * sp(im);

end

function cd = crowdingdistance(c, f, m)

% c: cost functions
% f: cost function fronts
% m: min or maximization indicators

if size(f, 2) == 1
    
    fnum = [1:numel(f)]';
    f = [fnum, f];    
    
end


nc = size(c, 2);
cd = zeros(size(c));
nf = max(f(:, 2)) - min(f(:, 2)) + 1;
minf = min(f(:, 2));

for i = 1:nc
    
    for j = 1:nf
        
        fj = f(f(:, 2) == j-1+minf, 1);
        cf = c(fj, :);
        [sc, so] = sort(cf(:, i));
    
        if numel(sc) >= 3
            
            cd(fj(so(2:end-1)), i) = (sc(3:end) - sc(1:end-2)) / (sc(end)- sc(1));
            cd(fj(so(1 + m(i) * (end - 1))), i) = inf;
            % cd(fj(so( (1 - m(i)) * end + m(i) )), i) = cd(fj(so((1 - m(i)) * (end - 1) + m(i) *  2)));
            cd(fj(so( (1 - m(i)) * end + m(i) )), i) = inf;
            
        elseif numel(sc) == 2
            
            % cd(fj(so(1+m(i))), i) = inf;
            cd(fj, i) = inf;
            
        end
        
    end
    
end

cd = sum(cd, 2);
end

function p = roulettewheel(cost, m)

if m == 0
    wc = max(cost);
    f = exp(-cost/wc)./sum(exp(-cost/wc));
else
   f = cost/sum(cost);
end



cumf = cumsum(f);
r = rand;
p = find(r <= cumf, 1, 'first');

end

function ippop = checklimits(ppop, limitcheck)

npop = size(ppop, 1);
npath = size(ppop, 2);
ippop = zeros(npop, 1);

for i = 1:npop
    for j = 1:npath
       ippop(i) = ippop(i) + limitcheck(ppop(i, j), j);
    end
end

ippop = ippop == npath; % 1 for passed solutions, 0 for out of bound solutions

end
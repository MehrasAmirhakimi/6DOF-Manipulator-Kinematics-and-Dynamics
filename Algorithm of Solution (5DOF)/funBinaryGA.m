function fbestsol = funBinaryGA(npop, ngen, id, th_path, limitcheck)
%% GA parameters


ngen_ini = ngen;
alpha = 0.3;
m = 0; % minimization problem: 0 or maximization problem: 1
nvar = size(id, 2); % number of variables
ncr = sum(id(1, :)); % each cromosome length
pc = 0.85; % probability of crossover
pm = 0.1; % probability of mutation
cross_p = [0.7, 0.15, 0.15];
mu = 0.1;
fa = 5;
fb = 0.05;
fc = 4*pi;

parse = @(x) parsepop(x, id);
docrossover = @(x1, x2) crossover(x1, x2, cross_p);
domutation = @(x) mutation(x, mu);
costfunction = @(x) objectivefun(x, th_path);

%% Create initial population

initpop = randi([0 1], [npop, ncr+1]);
ppop = parse(initpop);
initpop(:, end) = costfunction(ppop);

% global NFE
% NFE = 0;
% nfe = zeros(1, ngen);

%% main loop

bestsol = zeros(ngen_ini, ncr+1);
i = 0;
j = zeros(1, 3);
n = 0;

while n == 0;
    
    i = i+1;

    % do crossover
    crosspop = zeros(size(initpop));
    jx = 0;
    for ix = 1:npop/2
        a = rand;
        if a < pc
            jx = jx + 2;
            c1 = roulettewheel(initpop(:, end), m);
            c2 = roulettewheel(initpop(:, end), m);
            x1 = initpop(c1, 1:end-1);
            x2 = initpop(c2, 1:end-1);
            [y1, y2] = docrossover(x1, x2);
            crosspop(jx-1, 1:end-1) = y1;
            crosspop(jx, 1:end-1) = y2;
        end
    end
    crosspop(jx+1:end, :)=[];
    pcrosspop = parse(crosspop);
    crosspop(:, end) = costfunction(pcrosspop);
    
    % do mutation
    mutpop = zeros(size(initpop));
    jm = 0;
    for im = 1:npop
        b = rand;
        if b < pm
            jm = jm+1;
            c = roulettewheel(initpop(:, end), m);
            x = initpop(c, 1:end-1);
            y = domutation(x);
            mutpop(jm, 1:end-1) = y;
        end
    end
    mutpop(jm+1:end, :)=[];
    pmutpop = parse(mutpop);
    mutpop(:, end) = costfunction(pmutpop);
    
    % going to next generation
    pop = zeros(npop, ncr+1);
    pop(1:jx, :) = crosspop;
    
    if jx+jm <= npop
        
        pop(jx+1:jx+jm, :) = mutpop;
        
        for ii = 1:npop-(jx+jm)
           f = roulettewheel(initpop(:, end), m);
           pop(jx+jm+ii, :) = initpop(f, :);
        end
        
    else
        
        for jj = 1:npop-jx
           f = roulettewheel(mutpop(:, end), m);
           pop(jx+jj, :) = mutpop(f, :);
        end
        
    end
    
    % save elite cromosome
    if m == 0
        [~, w] = max(pop(:, end));
    else
        [~, w] = min(pop(:, end));
    end
    pop(w, :) = pickelite(initpop, crosspop, mutpop, m);
    initpop = pop;
    
    if m == 0
        [~, b] = min(pop(:, end));
    else
        [~, b] = max(pop(:, end));
    end
    
    % nfe(i) = NFE;
    bestsol(i, :) = pop(b, :);
   
    % pause condition
    
    if i < 2 * ngen_ini
        n = 0;
    elseif bestsol(i, end) - bestsol(i-1, end) ~= 0
        j(1) = 0;
    else
        j(1) = j(1)+1;
    end
    
    if j(1) > alpha * ngen_ini
        pc = 0.6;
        pm = 0.4;
        cross_p = [0.5, 0.3, 0.2];
        mu = 0.1;
        j(2) = j(2)+1;
    else
        pc = 0.8;
        pm = 0.1;
        cross_p = [0.7, 0.15, 0.15];
        mu = 0.1;
    end
    
    if j(2) > ngen_ini
        j(1) = 0;
        j(3) = j(3) + 1;
    end
    
    if j(3) > 2 * ngen_ini
        n = 1;
    end
    
    bestcost = bestsol(i, end);
    fprintf('generation: %g, bestcost: %g \n', i, bestcost);
end

%% showing the results

plot(1:size(bestsol, 1), bestsol(:, end), 'LineWidth', 2);

fprintf('best solution is: \n');
parse(bestsol(end, :))

end

%% sub-functions

function obj = objectivefun(ppop, th_path)
% global adebug
npop = size(ppop, 1);
obj = zeros(npop, 1);
npath = size(ppop, 2);
nd = size(th_path, 2);
thpoint = zeros(nd, npath);

delthpoint = zeros(nd, npath-1);

for i = 1:npop
    
    
    for j = 1:npath
%         adebug = th_path(ppop(i, j), :, j);
        thpoint(:, j) = th_path(ppop(i, j), :, j)';
    end
    
    
    for j = 1:npath-1
       delthpoint(:, j) = thpoint(:, j+1) - thpoint(:, j);
    end
    
    delthpoint = sum(abs(delthpoint), 2);
    obj(i) = sum([4; 6; 5; 3; 2] .* delthpoint); % Objective: joint angel distances
      
    
end


end

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

function p = roulettewheel(cost, m)

%if m == 0
%    f = (1./cost)/sum(1./cost);
%else
%    f = cost/sum(cost);
%end

wc = max(cost);
f = exp(-cost/wc) ./ sum(exp(-cost/wc));

cumf = cumsum(f);
r = rand;
p = find(r <= cumf, 1, 'first');

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

function y = pickelite(initpop, crosspop, mutpop, m)

totalpop = [initpop; crosspop; mutpop];

if m == 0;
    [~, f] = min(totalpop(:, end));
    y = totalpop(f, :);
else
    [~, f] = max(totalpop(:, end));
    y = totalpop(f, :);
end

end
function ShowManipulator(DH)

n = size(DH, 1);
points = zeros(3, 2*n+2);
x = zeros(3, n+1);
y = zeros(3, n+1);
z = zeros(3, n+1);

points(:, 1) = [0; 0; 0];
points(:, 2) = [0; 0; DH(1, 3)];
x(:, 1) = [1; 0; 0];
y(:, 1) = [0; 1; 0];
z(:, 1) = [0; 0; 1];

for i = 2:n
   
    T = ForKin(DH(1:i-1, :), 1);
    p1 = T(1:3, 4);
    p2 = T*[0; 0; DH(i,3); 1];
    p2 = p2(1:3);
    points(:, 2*(i-1)+1) = p1;
    points(:, 2*i) = p2;
    
    xx = T*[1; 0; 0; 1];
    x(:, i) = xx(1:3);
    yy = T*[0; 1; 0; 1];
    y(:, i) = yy(1:3);
    zz = T*[0; 0; 1; 1];
    z(:, i) = zz(1:3);
    
end

T = ForKin(DH, 1);
p1 = T(1:3, 4);
points(:, 2*n+1) = p1;
points(:, 2*n+2) = p1;
xx = T*[1; 0; 0; 1];
x(:, n+1) = xx(1:3);
yy = T*[0; 1; 0; 1];
y(:, n+1) = yy(1:3);
zz = T*[0; 0; 1; 1];
z(:, n+1) = zz(1:3);

figure
grid on
hold on

for i = 1:2*n-1
    
    p1 = points(:, i);
    p2 = points(:, i+1);
    lx = [p1(1), p2(1)];
    ly = [p1(2), p2(2)];
    lz = [p1(3), p2(3)];
    
    
    if mod(i, 2) == 0
        plot3(lx, ly, lz, 'r','LineWidth', 2);
    else
        plot3(lx, ly, lz, 'LineWidth', 2);
    end
    
end

for i = 1:n+1
    
    o = points(:, 2*(i-1)+1);
    px = x(:, i);
    py = y(:, i);
    pz = z(:, i);
    
    fxx = [o(1), px(1)];
    fxy = [o(2), px(2)];
    fxz = [o(3), px(3)];
    fyx = [o(1), py(1)];
    fyy = [o(2), py(2)];
    fyz = [o(3), py(3)];
    fzx = [o(1), pz(1)];
    fzy = [o(2), pz(2)];
    fzz = [o(3), pz(3)];
    
    plot3(fxx, fxy, fxz, 'k');
    plot3(fyx, fyy, fyz, 'k');
    plot3(fzx, fzy, fzz, 'k');
    
end

xlabel('x')
ylabel('y')
zlabel('z')

end
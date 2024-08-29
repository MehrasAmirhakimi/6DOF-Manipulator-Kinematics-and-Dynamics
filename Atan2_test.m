clc
clear all
close all
x = linspace(-1, 1, 70);
y = linspace(-1, 1, 70);
[X, Y] = meshgrid(x, y);
Theta = zeros(size(X));
for i = 1:numel(x)
    
   for j = 1:numel(y)
       
       xx = X(i, j);
       yy = Y(i, j);
       Theta(i, j) = Atan2(yy, xx);
       
   end
    
end
surf(X, Y, Theta);
xlabel('x');
ylabel('y');
zlabel('theta');
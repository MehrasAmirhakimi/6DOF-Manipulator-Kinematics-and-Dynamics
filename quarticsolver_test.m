clc
clear all
close all
syms x

n = 1000;
sol1 = zeros(4, n);
sol2 = zeros(4, n);

for i = 1:n
    co = rand(1, 5) - 0.5;
    
    sol1(:, i) = quarticsolver(co);
    [~, n1] = sort(real(sol1(:, i)) + imag(sol1(:, i)));
    sol1(:, i) = sol1(n1, i);
    
    sol2(:, i) = solve(co(5)*x^4+co(4)*x^3+co(3)*x^2+co(2)*x+co(1));
    [~, n2] = sort(real(sol2(:, i)) + imag(sol2(:, i)));
    sol2(:, i) = sol2(n2, i);
end

%% overal errors on solutions
er1 = sol1 - sol2;
rer1 = real(er1);
ier1 = imag(er1);
er2 = (rer1.^2 + ier1.^2).^0.5;
den = (real(sol2).^2 + imag(sol2).^2).^0.5;
den2 = imag(sol2);
er3 = er2./den;
er4 = sum(er3, 1)/4;

rer2 = abs(rer1)./den;
rer3 = sum(rer2, 1)/4;

ier2 = abs(ier1)./den;
ier3 = sum(ier2, 1)/4;
ier4 = max(abs(ier1./imag(sol1)));
rer4 = max(abs(rer1./real(sol1)));
plot(1:n, er4, 1:n, rer3, 1:n, ier3)
axis([1, n, 0, 1.5*max([rer3, ier3])])
legend('total error', 'real error', 'imagenary error')

figure
plot(1:n, max(abs(rer1)), 1:n, rer4)

figure
plot(1:n, max(abs(ier1)), 1:n, ier4)
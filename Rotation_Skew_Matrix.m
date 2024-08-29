clc
clear all
close all

n = 100;
alphas = linspace(pi/6, pi/2, n);
betas = linspace(0, pi/3, n);
gammas = linspace(-pi/4, pi/12, n);

figure
grid on
view(30,30)
axis([-1, 2, -1, 2, -1, 2])

for i = 1:100
    pause(0.1);
    cla
    R = EulerZYX([alphas(i), betas(i), gammas(i)]);
    S = (R - eye(3))*inv(R + eye(3));

    a = zeros(3, 1);
    a(1) = S(3, 2);
    a(2) = S(1, 3);
    a(3) = S(2, 1);

    o = zeros(3, 1);
    px = R(:, 1);
    py = R(:, 2);
    pz = R(:, 3);

    fxx = [o(1), px(1)];
    fxy = [o(2), px(2)];
    fxz = [o(3), px(3)];
    fyx = [o(1), py(1)];
    fyy = [o(2), py(2)];
    fyz = [o(3), py(3)];
    fzx = [o(1), pz(1)];
    fzy = [o(2), pz(2)];
    fzz = [o(3), pz(3)];

    hold on
    
    plot3(fxx, fxy, fxz, 'b');
    plot3(fyx, fyy, fyz, 'g');
    plot3(fzx, fzy, fzz, 'r');

    plot3([o(1), a(1)], [o(2), a(2)], [o(3), a(3)], 'k');
    
    hold off

end
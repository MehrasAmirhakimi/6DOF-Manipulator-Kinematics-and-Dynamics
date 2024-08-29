clc
clear all
close all

%% manipulator parameters

% a4, a5, d5 must be zero
a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0.065*10;

%% initial & final states

theta1i = 30  *pi/180;
theta2i = 45  *pi/180;
theta3i = 20  *pi/180;
theta4i = 45  *pi/180;
theta5i = 20  *pi/180;
theta6i = 10  *pi/180;

DHi = [-pi/2, a1, d1, theta1i;
          0, a2, d2, theta2i;
      -pi/2, a3, d3, theta3i;
       pi/2,  0, d4, theta4i;
      -pi/2,  0,  0, theta5i;
          0,  0, d6, theta6i];
      
Ti = ForKin(DHi, 1);

theta1f = 10  *pi/180;
theta2f =-10  *pi/180;
theta3f = 10  *pi/180;
theta4f = 30  *pi/180;
theta5f = 20  *pi/180;
theta6f = 60  *pi/180;

DHf = [-pi/2, a1, d1, theta1f;
          0, a2, d2, theta2f;
      -pi/2, a3, d3, theta3f;
       pi/2,  0, d4, theta4f;
      -pi/2,  0,  0, theta5f;
          0,  0, d6, theta6f];
      
Tf = ForKin(DHf, 1);

%% path generation

n = 100;
Tpath = zeros(4, 4, n);
Tpath(4, 4, :) = 1;
Tpath(1, 4, :) = linspace(Ti(1, 4), Tf(1, 4), n);
Tpath(2, 4, :) = linspace(Ti(2, 4), Tf(2, 4), n);
Tpath(3, 4, :) = linspace(Ti(3, 4), Tf(3, 4), n);
anglesi = solEulerZYX(Ti(1:3, 1:3));
anglesf = solEulerZYX(Tf(1:3, 1:3));
anglespath = zeros(1, 3, n);
anglespath(1, 1, :) = linspace(anglesi(1, 1), anglesf(1, 1), n);
anglespath(1, 2, :) = linspace(anglesi(1, 2), anglesf(1, 2), n);
anglespath(1, 3, :) = linspace(anglesi(1, 3), anglesf(1, 3), n);

sol = zeros(8, 6, n);
realindex = zeros(8, n);
DH = DHi;

for i = 1:n
    
    Tpath(1:3, 1:3, i) = EulerZYX(anglespath(1, :, i));
%     Tpath(1:3, 1:3, i) = Ti(1:3, 1:3);
    [sol(:, :, i), realindex(:, i)] = PieperIK(DH, Tpath(:, :, i));
    
end

psol = zeros(n, 6);
psol(1, :) = DHi(:, 4)';

for i = 2:n
    soli = sol(:, :, i);
    realindexi = realindex(:, i);
    %isoli = sum(imag(soli), 2);
    tsol = soli(realindexi == 1, :);
    dsol = sdm(psol(i-1, :), tsol);
    [~, nmin] = min(dsol);
    psol(i, :) = tsol(nmin, :);
    
end


for i = 1:n
    
    DH(:, 4) = sol(1, :, i)';
    ManipolatorShow(DH)
    axis([-4, 5, -4, 5, -2, 6])
    view(45,30)
    pause(0.1);
    cla
end
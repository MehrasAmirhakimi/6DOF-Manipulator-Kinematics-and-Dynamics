%% Initialization
clc;
clear all;
close all

%% test1
n_path = 10;
x_Task = linspace(-3, 0, n_path);
y_Task = linspace(2, 3, n_path);
z_Task = linspace(3.52, 7.52, n_path);
xyz = [x_Task; y_Task; z_Task];
abg = repmat([30; 45; 30], [1, n_path]);
fnb = zeros(6, n_path);
lo = 0;
va = 0.75; %Cte (m/s)
ac = 0.5*0.001; %Cte (m)
dt = ac/va; %Cte (s)
[T_path, V_path, fne] = TaskGeneration(xyz, abg, fnb, lo, va, dt);
%%
% DOF = 5; %Cte
ns = 8; % number of solutions
% xyz = 10*rand(3, 1000);
% abg = 90*rand(3, 1000);
% fnb = repmat([0; 0; 5; 0; 0; 1.2], [1, 1000]);

ws = 0.7^3*pi*4/3; %Cte (m^3)

% a4, a5, d5 must be zero
a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0.25*10;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0;

DH = [-pi/2, a1, d1, 0;
          0, a2, d2, 0;
      -pi/2, a3, d3, 0;
       pi/2,  0, d4, 0;
      -pi/2,  0,  0, 0;
          0,  0, d6, 0];

ThLimits = [-30, 60;
            -45, 30;
            -30, 45;
            -60, 45;
            -45, 60;
            -60, 60]*pi/180;
% M_robot =
% I_robot = 
% DH = input('Denavit-Hartenberg Of Robot: ');
% M_robot = input('Mass Of Robot: ');
% I_robot = input('Inertia Of Robot: ');
nd = size(DH, 1)-1; % note 1
th_path = zeros(ns, nd+1, n_path);
realindex = zeros(ns, n_path);
J_path = zeros(6, nd, n_path, 8);
thdot_path = zeros(ns, nd, n_path);

%% Inverse Kinematics

for i=1:n_path
    [th_path(:,:,i), realindex(:, i)] = PieperIK(DH,T_path(:,:,i));
end

DH = DH(1:nd, :);
th_path = th_path(:, 1:nd, :);

%% Joint Angel Limits

th_limitcheck = zeros(ns, nd, n_path);

for i = 1:nd
   th_limitcheck(:, i, :) = (th_path(:, i, :) < ThLimits(i, 2)).*(th_path(:, i, :) > ThLimits(i, 1));
end

limitcheck = reshape(sum(th_limitcheck, 2), [ns, n_path]);
limitcheck = limitcheck == nd;

%% Jacobian Calculation

for i = 1:n_path
   for j = 1:ns
       DH(:, 4) = th_path(j, :, i);
       J_path(:, :, i, j) = Jacobi2(DH);
   end
end

%% Joint Angel Rates

for i = 1:n_path
   for j = 1:ns
      pinvJ = pinv(J_path(:, :, i, j));
      thdot_path(j, :, i) = (pinvJ*V_path(:, i))';
   end
end

%% Path Generation

% 1- Point Selection & determining joint angels and joint angel rates
% (sth_path & sthdot_path)

points = optimpath2(th_path, realindex, limitcheck, thdot_path, J_path, dt);
sth_path = zeros(nd, n_path); % selected path joint angels
sthdot_path = zeros(nd, n_path); % selected path joint angel rates

for i = 1:n_path
   sth_path(:, i) = th_path(points(i), :, i);
   sthdot_path(:, i) = thdot_path(points(i), :, i);
end

% 2- determinig joint angel accelerations (sthddot_path)

sthddot_path = zeros(nd, n_path); % selected path joint angel accelerations

for i=1:n_path-1
    sthddot_path(:,i) = (sthdot_path(:, i+1) - sthdot_path(:, i))/dt;
end
sthddot_path(:, end) = sthddot_path(:, end-1);

% %% Inverse Dynamics
% Torque = zeros(nd, n_path);
% for i=1:n_path
%     DH = [DH(:,1:3), sth_path(:, i)];
%     Torque(:, i) = DynamicTorque(DH, sthdot_path(:, i), sthddot_path(:, i), M_robot, I_robot, Pc, fne(:, i));
% end
% Tmax = max(Torque, [], 2)


%% Stress Calculation

%% Update Robots

%% Erorr Calculation

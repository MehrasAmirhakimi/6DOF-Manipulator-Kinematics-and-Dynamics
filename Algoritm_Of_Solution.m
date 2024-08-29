%% Initialization
clc;
clear all;

DOF = 6; %Cte
ws = 0.7^3*pi*4/3; %Cte (m^3)
lo = 0.5; %Cte (kg)
vl = 0.75; %Cte (m/s)
ac = 0.5*0.001; %Cte (m)
ts = ac/vl; %Cte (s)
% a4, a5, d5 must be zero
a1 = 0.07*10;
a2 = 0.36*10;
a3 = 0;

d1 = 0.352*10;
d2 = 0;
d3 = 0;
d4 = 0.38*10;
d6 = 0.065*10;

DH = [-pi/2, a1, d1, 0;
          0, a2, d2, 0;
      -pi/2, a3, d3, 0;
       pi/2,  0, d4, 0;
      -pi/2,  0,  0, 0;
          0,  0, d6, 0];

% M_robot =
% I_robot = 
% DH = input('Denavit-Hartenberg Of Robot: ');
% T_path = input('Transfer Matrix Of Work: ');
% F_path = input('Force Of Work: ');
% N_path = input('Torqe Of Work: ');
% M_robot = input('Mass Of Robot: ');
% I_robot = input('Inertia Of Robot: ');
FN = [F;N];
n_path = size(T_path,3); % number of path point
P_path = T_path(1:3,4,:);
R_path = T_path(1:3,1:3,:);
th_path = zeros(8,6,n_path);
realindex = zeros(8, n_path);
J_path = zeros(6, 6, n_path, 8);
thdot_path = zeros(8,6,n_path);
v_path = zeros(3,1,n_path);
w_path = zeros(3,1,n_path);
for i=1:n_path
    v_path(:,:,i) = vl*(P_path(:,:,i+1)-P_path(:,:,i))/sqrt(sum((P_path(:,:,i+1)-P_path(:,:,i)).^2));
    S = (R_path(:,:,i+1)-R_path(:,:,i))*R_path(:,:,i)'/ts;
    w_path(:,:,i) = [S(3, 2); S(1, 3); S(2, 1)];
end
V_path = [v_path;w_path];

%% Inverse Kinematics

for i=1:n_path
    [th_path(:,:,i), realindex(:, i)] = PieperIK(DH,T_path(:,:,i));
end

%% Jacobian Calculation

for i = 1:n_path
   for j = 1:8
       DH(:, 4) = th_path(j, :, i);
       J_path(:, :, i, j) = OSJacobi(DH);
   end
end

%% Joint Angel Rates

for i = 1:n_path
   for j = 1:8
      pinvJ = pinv(J_path(:, :, i, j));
      thdot_path(j, :, i) = (pinvJ*V_path(:, :, i))';
   end
end

%% Path Generation

% 1- Point Selection & determining joint angels and joint angel rates
% (sth_path & sthdot_path)

points = optimpath(th_path, realindex, thdot_path, J_path, dt);
sth_path = zeros(6, n_path); % selected path joint angels
sthdot_path = zeros(6, n_path); % selected path joint angel rates

for i = 1:n_path
   sth_path(:, i) = th_path(points(i), :, i);
   sthdot_path(:, i) = thdot_path(points(i), :, i);
end

% 2- determinig joint angel accelerations (sthddot_path)

sthddot_path = zeros(6,n_path); % selected path joint angel accelerations

for i=1:n_path-1
    sthddot_path(:,i) = (sthdot_path(:, i+1) - sthdot_path(:, i))/ts;
end
sthddot_path(:, end) = sthddot_path(:, end-1);

%% Inverse Dynamics
Torque = zeros(6,n_path);
for i=1:n_path
    DH = [DH(:,1:3), sth_path(:, i)];
    Torque(:, i) = DynamicTorque(DH, sthdot_path(:, i), sthddot_path(:, i), M_robot, I_robot, Pc, FN(:, i));
end
Tmax = max(Torque, [], 2)


%% Stress Calculation

%% Update Robots

%% Erorr Calculation

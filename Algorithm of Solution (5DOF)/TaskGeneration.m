function [T_path, V_path, fne] = TaskGeneration(xyz, abg, fnb, lo, va, dt)


% xyz & abg are 3 by n_path matrices, and fnb is 6 by n_path
% lo (load) is the weight of the mass grasped by end effector
% va is velocity absolute value


n_path = size(xyz, 2);
T_path = zeros(4, 4, n_path);
R_path = zeros(3, 3, n_path);
P_path = zeros(3, n_path);
fne = zeros(6, n_path);
Z = [0; 0; 1];
g = 9.81;
Tfun = @(alpha, beta, gama, x, y, z)[cos((pi*beta)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - cos((pi*alpha)/180)^2*cos((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) + sin((pi*alpha)/180)*sin((pi*beta)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)),                                                                      - sin((pi*alpha)/180)*(cos((pi*gama)/180) - cos((pi*alpha)/180)^2*cos((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)), -cos((pi*alpha)/180)*cos((pi*beta)/180)    ,x;
                                   - cos((pi*beta)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*sin((pi*beta)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - cos((pi*beta)/180)^2*sin((pi*alpha)/180)^2*(cos((pi*gama)/180) - 1)),                                                                        cos((pi*alpha)/180)*(cos((pi*gama)/180) - cos((pi*beta)/180)^2*sin((pi*alpha)/180)^2*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)), -cos((pi*beta)/180)*sin((pi*alpha)/180) ,y;
                                   cos((pi*beta)/180)*(cos((pi*gama)/180) - sin((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) + cos((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)), cos((pi*alpha)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) + sin((pi*alpha)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)),                     -sin((pi*beta)/180)        ,z;
                                   0,0,0,1];

for i = 1:n_path
    alpha = abg(1, i);
    beta = abg(2, i);
    gama = abg(3, i);
    x = xyz(1, i);
    y = xyz(2, i);
    z = xyz(3, i);
    T_path(:, :, i) = Tfun(alpha, beta, gama, x, y, z);
    P_path(:, i) = T_path(1:3, 4, i);
    R_path(:, :, i) = T_path(1:3, 1:3, i);
    fne(1:3, i) = R_path(:, :, i)'*(fnb(1:3, i)-lo*g*Z);
    fne(4:6, i) = R_path(:, :, i)'*fnb(4:6, i);    
end


v_path = zeros(3, n_path);
w_path = zeros(3, n_path);

for i=1:n_path-1
    v_path(:, i) = va*(P_path(:, i+1) - P_path(:, i))/sqrt(sum((P_path(:, i+1) - P_path(:, i)).^2));
    S = (R_path(:, :, i+1) - R_path(:, :, i))*R_path(:, :, i)'/dt;
    w_path(:, i) = [S(3, 2); S(1, 3); S(2, 1)];
end

v_path(:, n_path) = v_path(:, n_path-1);
w_path(:, n_path) = w_path(:, n_path-1);
V_path = [v_path; w_path];


end
function sol = solEulerZYX(R)

sol = zeros(2, 3);
sol(1, 2) = atan2(-R(3, 1), (R(1, 1)^2 + R(2, 1)^2)^0.5);
sol(2, 2) = atan2(-R(3, 1), -(R(1, 1)^2 + R(2, 1)^2)^0.5);

if cos(sol(1, 2)) ~= 0
    sol(1, 1) = atan2(R(2, 1)/cos(sol(1, 2)), R(1, 1)/cos(sol(1, 2)));
    sol(2, 1) = atan2(R(2, 1)/cos(sol(2, 2)), R(1, 1)/cos(sol(2, 2)));
    sol(1, 3) = atan2(R(3, 2)/cos(sol(1, 2)), R(3, 3)/cos(sol(1, 2)));
    sol(2, 3) = atan2(R(3, 2)/cos(sol(2, 2)), R(3, 3)/cos(sol(2, 2)));
elseif sol(1, 2) == pi/2
    sol(1, 1) = 0;
    sol(1, 3) = atan2(R(1, 2), R(2, 2));
    sol(2, :) = [];
else
    sol(1, 1) = 0;
    sol(1, 3) = -atan2(R(1, 2), R(2, 2));
    sol(2, :) = [];
end

end
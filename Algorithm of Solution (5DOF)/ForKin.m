function T = ForKin(DH, type)

n = size(DH, 1);
T = eye(4);
TT = eye(4);
switch type
    case 1
        
        for i = n:-1:1
            alpha = DH(i, 1);
            a = DH(i, 2);
            d = DH(i, 3);
            theta = DH(i, 4);
            TT(1, 1) = cos(theta);
            TT(1, 2) = -sin(theta)*cos(alpha);
            TT(1, 3) = sin(theta)*sin(alpha);
            TT(1, 4) = a*cos(theta);
            TT(2, 1) = sin(theta);
            TT(2, 2) = cos(theta)*cos(alpha);
            TT(2, 3) = -cos(theta)*sin(alpha);
            TT(2, 4) = a*sin(theta);
            TT(3, 2) = sin(alpha);
            TT(3, 3) = cos(alpha);
            TT(3, 4) = d;
%             T = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), a*cos(theta);
%                 sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
%                 0, sin(alpha), cos(alpha), d;
%                 0, 0, 0, 1] * T;
            T = TT*T;
            
        end
        
        
    case 2
        
        for i = n:-1:1
            alpha = DH(i, 1);
            a = DH(i, 2);
            d = DH(i, 3);
            theta = DH(i, 4);
            T = [cos(theta), -sin(theta), 0, a;
                sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
                sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha), cos(alpha)*d;
                0, 0, 0, 1] * T;
        end        
        
end






end
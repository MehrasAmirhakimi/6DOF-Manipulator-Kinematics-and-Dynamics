function J = Jacobi2(DH)


nd = size(DH, 1);
Z = [0; 0; 1];
J = zeros(6, nd);


for i = 1:nd
   
    for j = 0:nd-i
       
        T1 = ForKin(DH(nd-j:nd, :), 1);
        R1 = T1(1:3, 1:3);
        
        T2 = ForKin(DH(i:nd-j-1, :), 1);
        R2 = T2(1:3, 1:3);
        
        T3 = ForKin(DH(nd-j, :), 1);
        P3 = T3(1:3, 4);
        
        J(1:3, i) = J(1:3, i) + R1'*cross(R2'*Z, P3);
        
    end
    
    T4 = ForKin(DH(i:nd, :), 1);
    R4 = T4(1:3, 1:3);
    
    J(4:6, i) = R4'*Z;
end

T = ForKin(DH, 1);
R = T(1:3, 1:3);
RR = zeros(6, 6);
RR(1:3, 1:3) = R;
RR(4:6, 4:6) = R;
J = RR*J;

end
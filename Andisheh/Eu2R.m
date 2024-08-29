function Eu2R=Eu2R(alpha,beta,gama)
if size(alpha,1)==size(alpha,2)==size(beta,1)==size(beta,2)==size(gama,1)==size(gama,2)==1
    alpha=alpha*pi()/180;
    beta=beta*pi()/180;
    gama=gama*pi()/180;
    C=@(teta)cos(teta);
    S=@(teta)sin(teta);
    R=[C(alpha)*C(beta),C(alpha)*S(beta)*S(gama)-S(alpha)*C(gama),C(alpha)*S(beta)*C(gama)+S(alpha)*S(gama);
        S(alpha)*C(beta),S(alpha)*S(beta)*S(gama)+C(alpha)*C(gama),S(alpha)*S(beta)*C(gama)-C(alpha)*S(gama);
        -S(beta),C(beta)*S(gama),C(beta)*C(gama);];
    Eu2R=R;
else
    disp('Erorr')
    disp('Invalid Input!')
    disp('Please Try Again')
end
end
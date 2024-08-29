function Rotmat=rotmat(alpha,beta,gama)
if size(alpha,1)==size(alpha,2)==size(beta,1)==size(beta,2)==size(gama,1)==size(gama,2)==1
    alpha=alpha*pi()/180;
    beta=beta*pi()/180;
    gama=gama*pi()/180;
    C=@(teta)cos(teta);
    S=@(teta)sin(teta);
    Rotx=@(teta)([1,0,0,0;0,C(teta),(-S(teta)),0;0,(S(teta)),C(teta),0;0,0,0,1]);
    Roty=@(teta)([C(teta),0,S(teta),0;0,1,0,0;(-S(teta)),0,C(teta),0;0,0,0,1]);
    Rotz=@(teta)([C(teta),(-S(teta)),0,0;(S(teta)),C(teta),0,0;0,0,1,0;0,0,0,1]);
    Rotmat=Rotz(gama)*Roty(beta)*Rotx(alpha);
else
    disp('Erorr')
    disp('Invalid Input!')
    disp('Please Try Again')
end
end
syms alpha beta gama real

C = @(teta) cos(teta*pi/180);
S = @(teta) sin(teta*pi/180);
V = @(teta) 1-cos(teta*pi/180);

e = [C(beta)*C(alpha);
     C(beta)*S(alpha);
     S(beta)];
al = [-S(alpha);
     C(alpha);
     0];
be = [-S(beta)*C(alpha);
     -S(beta)*S(alpha);
     C(beta)];

ex = e(1);
ey = e(2);
ez = e(3);

Re = [ex*ex*V(gama)+C(gama), ex*ey*V(gama)-ez*S(gama), ex*ez*V(gama)+ey*S(gama);
      ex*ey*V(gama)+ez*S(gama), ey*ey*V(gama)+C(gama), ey*ez*V(gama)-ex*S(gama);
      ex*ez*V(gama)-ey*S(gama), ey*ez*V(gama)+ex*S(gama), ez*ez*V(gama)+C(gama)];
  
c = -e;
b = Re*al;
a = Re*be;

R = [a,b,c];
R2 = @(alpha, beta, gama) [cos((pi*beta)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - cos((pi*alpha)/180)^2*cos((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) + sin((pi*alpha)/180)*sin((pi*beta)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)),                                                                      - sin((pi*alpha)/180)*(cos((pi*gama)/180) - cos((pi*alpha)/180)^2*cos((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)), -cos((pi*alpha)/180)*cos((pi*beta)/180);
                            - cos((pi*beta)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*sin((pi*beta)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - cos((pi*beta)/180)^2*sin((pi*alpha)/180)^2*(cos((pi*gama)/180) - 1)),                                                                        cos((pi*alpha)/180)*(cos((pi*gama)/180) - cos((pi*beta)/180)^2*sin((pi*alpha)/180)^2*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)), -cos((pi*beta)/180)*sin((pi*alpha)/180);
                             cos((pi*beta)/180)*(cos((pi*gama)/180) - sin((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) + cos((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)), cos((pi*alpha)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) + sin((pi*alpha)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)),                     -sin((pi*beta)/180)];

T = @(alpha, beta, gama, x, y, z)[cos((pi*beta)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - cos((pi*alpha)/180)^2*cos((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) + sin((pi*alpha)/180)*sin((pi*beta)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)),                                                                      - sin((pi*alpha)/180)*(cos((pi*gama)/180) - cos((pi*alpha)/180)^2*cos((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)), -cos((pi*alpha)/180)*cos((pi*beta)/180)    ,x;
                                   - cos((pi*beta)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) + cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - cos((pi*alpha)/180)*sin((pi*beta)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - cos((pi*beta)/180)^2*sin((pi*alpha)/180)^2*(cos((pi*gama)/180) - 1)),                                                                        cos((pi*alpha)/180)*(cos((pi*gama)/180) - cos((pi*beta)/180)^2*sin((pi*alpha)/180)^2*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*(sin((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*alpha)/180)*cos((pi*beta)/180)^2*sin((pi*alpha)/180)*(cos((pi*gama)/180) - 1)), -cos((pi*beta)/180)*sin((pi*alpha)/180) ,y;
                                   cos((pi*beta)/180)*(cos((pi*gama)/180) - sin((pi*beta)/180)^2*(cos((pi*gama)/180) - 1)) + cos((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) - sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)), cos((pi*alpha)/180)*(cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*gama)/180) - cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)) + sin((pi*alpha)/180)*(cos((pi*beta)/180)*sin((pi*alpha)/180)*sin((pi*gama)/180) + cos((pi*alpha)/180)*cos((pi*beta)/180)*sin((pi*beta)/180)*(cos((pi*gama)/180) - 1)),                     -sin((pi*beta)/180)        ,z;
                                   0,0,0,1];



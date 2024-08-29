function sol = quarticsolver(coeffs)

e = coeffs(1);
d = coeffs(2);
c = coeffs(3);
b = coeffs(4);
a = coeffs(5);

p = (8*a*c-3*b^2)/(8*a^2);
q = (b^3-4*a*b*c+8*a^2*d)/(8*a^3);
delta0 = c^2-3*b*d+12*a*e;
delta1 = 2*c^3-9*b*c*d+27*b^2*e+27*a*d^2-72*a*c*e;
Q = ((delta1+(delta1^2-4*delta0^3)^0.5)/2)^(1/3);
S = 0.5*(-2/3*p+1/(3*a)*(Q+delta0/Q))^0.5;

x1 = -b/(4*a)-S+0.5*(-4*S^2-2*p+q/S)^0.5;
x2 = -b/(4*a)-S-0.5*(-4*S^2-2*p+q/S)^0.5;
x3 = -b/(4*a)+S+0.5*(-4*S^2-2*p-q/S)^0.5;
x4 = -b/(4*a)+S-0.5*(-4*S^2-2*p-q/S)^0.5;
sol = [x1; x2; x3; x4];

% noncomplex solution correction threshold
isol1 = imag(sol);
isol2 = abs(isol1) < 1e-10 & isol1 ~= 0;
sol(isol2) = real(sol(isol2));

% nozero real parts correction threshold
rsol1 = real(sol);
rsol2 = abs(rsol1) < 1e-10 & rsol1 ~= 0;
sol(rsol2) = sol(rsol2) - real(sol(rsol2));
end
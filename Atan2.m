function theta = Atan2(y, x)

if x==0 & y==0
    theta = 'undefined';
elseif x>=0
    theta = atan(y/x);
elseif x<0 & y>=0
    theta = atan(y/x)+pi;
else
    theta = atan(y/x)-pi;
end


end
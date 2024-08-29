clc;
clear all;
syms x;

mood=[0,0,0,0;0,109,122,3;0,114,122,30;0,109,122,x].';
n=size(mood,2);
o=zeros(4,n);
x=zeros(4,n);
y=zeros(4,n);
z=zeros(4,n);
t=eye(4);
o(:,1)=[0;0;0;1];
x(:,1)=[1;0;0;1];
y(:,1)=[0;1;0;1];
z(:,1)=[0;0;1;1];
figure;
hold on;
grid on;
axis([-10 10 -10 10 -10 10]);
plot3([o(1,1),x(1,1)],[o(2,1),x(2,1)],[o(3,1),x(3,1)],'color','m');
plot3([o(1,1),y(1,1)],[o(2,1),y(2,1)],[o(3,1),y(3,1)],'color','c');
plot3([o(1,1),z(1,1)],[o(2,1),z(2,1)],[o(3,1),z(3,1)],'color','b');
for i=2:n
    switch char(mood(2,i))
        case 'r'
            o(:,i)=rotmat_cartezianshow(char(mood(3,i)),mood(4,i))*o(:,i-1);
            x(:,i)=rotmat_cartezianshow(char(mood(3,i)),mood(4,i))*x(:,i-1);
            y(:,i)=rotmat_cartezianshow(char(mood(3,i)),mood(4,i))*y(:,i-1);
            z(:,i)=rotmat_cartezianshow(char(mood(3,i)),mood(4,i))*z(:,i-1);
            t=t*rotmat_cartezianshow(mood(3,i),mood(4,i));
        case 'm'
            o(:,i)=movmat_cartezianshow(char(mood(3,i)),mood(4,i))*o(:,i-1);
            x(:,i)=movmat_cartezianshow(char(mood(3,i)),mood(4,i))*x(:,i-1);
            y(:,i)=movmat_cartezianshow(char(mood(3,i)),mood(4,i))*y(:,i-1);
            z(:,i)=movmat_cartezianshow(char(mood(3,i)),mood(4,i))*z(:,i-1);
            t=t*movmat(mood(3,i),mood(4,i));
        otherwise
    end
    plot3([o(1,i-1),o(1,i)],[o(2,i-1),o(2,i)],[o(3,i-1),o(3,i)],'color','k','LineStyle',':');
    plot3([o(1,i),x(1,i)],[o(2,i),x(2,i)],[o(3,i),x(3,i)],'color','m');
    plot3([o(1,i),y(1,i)],[o(2,i),y(2,i)],[o(3,i),y(3,i)],'color','c');
    plot3([o(1,i),z(1,i)],[o(2,i),z(2,i)],[o(3,i),z(3,i)],'color','b');
end

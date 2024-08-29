clear all
clc
a1 = 4;
a2 = 6;
a3 = 9;

d1 = 5;
d2 = 4;
d3 = 2;
d4 = 4;

theta1 = 30  *pi/180;
theta2 = -20  *pi/180;
theta3 = -10  *pi/180;
theta4 = 45  *pi/180;
theta5 = 20  *pi/180;
theta6 = 50  *pi/180;

DH = [-pi/2, a1, d1, theta1;
          0, a2, d2, theta2;
      -pi/2, a3, d3, theta3;
      +pi/2,  0, d4, theta4;
      -pi/2,  0,  0, theta5;
          0,  0,  0.5, theta6];
title('Kinematics Show');
hold on;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
o = [0;0;0];
d = [0;0;0];
a = [0;0;0];
x = [1;0;0];
y = [0;1;0];
z = [0;0;1];
op = {'r','o',2};
dp = {'b','-',2};
ap = {'b','-',2};
gp = {'y','-',2};
xp = {'m','--',1};
yp = {'m',':',1};
zp = {'m','-',1};
plot3(o(1,1),o(2,1),o(3,1),'color',op{1},'Marker',op{2},'LineWidth',op{3});
plot3([o(1,1),x(1,1)],[o(2,1),x(2,1)],[o(3,1),x(3,1)],'color',xp{1},'LineStyle',xp{2},'LineWidth',xp{3});
plot3([o(1,1),y(1,1)],[o(2,1),y(2,1)],[o(3,1),y(3,1)],'color',yp{1},'LineStyle',yp{2},'LineWidth',yp{3});
plot3([o(1,1),z(1,1)],[o(2,1),z(2,1)],[o(3,1),z(3,1)],'color',zp{1},'LineStyle',zp{2},'LineWidth',zp{3});
n = size(DH,1);
T=eye;
    for i = 1:n
        alpha = DH(i, 1);
        A = DH(i, 2);
        D = DH(i, 3);
        theta = DH(i, 4);
        T = T*[cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), A*cos(theta);
            sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha), A*sin(theta);
            0, sin(alpha), cos(alpha), D;
            0, 0, 0, 1];
        o = [o(:,:),[T(1,4);T(2,4);T(3,4)]];
        x = [x(:,:),[T(1,1)+T(1,4);T(2,1)+T(2,4);T(3,1)+T(3,4)]];
        y = [y(:,:),[T(1,2)+T(1,4);T(2,2)+T(2,4);T(3,2)+T(3,4)]];
        z = [z(:,:),[T(1,3)+T(1,4);T(2,3)+T(2,4);T(3,3)+T(3,4)]];
        if i==n
            d =[d(:,:),(D-2)*(z(:,i)-o(:,i))+o(:,i)];
            a =[a(:,:),A*(x(:,i+1)-o(:,i+1))+d(:,i+1)];
            g =[1*(z(:,i+1)-o(:,i+1))+a(:,i+1),1*(y(:,i+1)-o(:,i+1))+(1*(z(:,i+1)-o(:,i+1))+a(:,i+1)),1*(z(:,i+1)-o(:,i+1))+(1*(y(:,i+1)-o(:,i+1))+(1*(z(:,i+1)-o(:,i+1))+a(:,i+1))),-1*(y(:,i+1)-o(:,i+1))+(1*(z(:,i+1)-o(:,i+1))+a(:,i+1)),1*(z(:,i+1)-o(:,i+1))+(-1*(y(:,i+1)-o(:,i+1))+(1*(z(:,i+1)-o(:,i+1))+a(:,i+1)))];
            xp = {'k','--',2};
            yp = {'k',':',2};
            zp = {'k','-',2};
            plot3(o(1,i+1),o(2,i+1),o(3,i+1),'color',op{1},'Marker',op{2},'LineWidth',op{3});
            plot3([o(1,i),d(1,i+1)],[o(2,i),d(2,i+1)],[o(3,i),d(3,i+1)],'color',dp{1},'LineStyle',dp{2},'LineWidth',dp{3});
            plot3([d(1,i+1),a(1,i+1)],[d(2,i+1),a(2,i+1)],[d(3,i+1),a(3,i+1)],'color',ap{1},'LineStyle',ap{2},'LineWidth',ap{3});
            plot3([o(1,i+1),x(1,i+1)],[o(2,i+1),x(2,i+1)],[o(3,i+1),x(3,i+1)],'color',xp{1},'LineStyle',xp{2},'LineWidth',xp{3});
            plot3([o(1,i+1),y(1,i+1)],[o(2,i+1),y(2,i+1)],[o(3,i+1),y(3,i+1)],'color',yp{1},'LineStyle',yp{2},'LineWidth',yp{3});
            plot3([o(1,i+1),z(1,i+1)],[o(2,i+1),z(2,i+1)],[o(3,i+1),z(3,i+1)],'color',zp{1},'LineStyle',zp{2},'LineWidth',zp{3});
            plot3([a(1,i+1),g(1,1)],[a(2,i+1),g(2,1)],[a(3,i+1),g(3,1)],'color',gp{1},'LineStyle',gp{2},'LineWidth',gp{3});
            plot3([g(1,1),g(1,2)],[g(2,1),g(2,2)],[g(3,1),g(3,2)],'color',gp{1},'LineStyle',gp{2},'LineWidth',gp{3});
            plot3([g(1,2),g(1,3)],[g(2,2),g(2,3)],[g(3,2),g(3,3)],'color',gp{1},'LineStyle',gp{2},'LineWidth',gp{3});
            plot3([g(1,1),g(1,4)],[g(2,1),g(2,4)],[g(3,1),g(3,4)],'color',gp{1},'LineStyle',gp{2},'LineWidth',gp{3});
            plot3([g(1,4),g(1,5)],[g(2,4),g(2,5)],[g(3,4),g(3,5)],'color',gp{1},'LineStyle',gp{2},'LineWidth',gp{3});
        else
            d =[d(:,:),D*(z(:,i)-o(:,i))+o(:,i)];
            a =[a(:,:),A*(x(:,i+1)-o(:,i+1))+d(:,i+1)];
            plot3(o(1,i+1),o(2,i+1),o(3,i+1),'color',op{1},'Marker',op{2},'LineWidth',op{3});
            plot3([o(1,i),d(1,i+1)],[o(2,i),d(2,i+1)],[o(3,i),d(3,i+1)],'color',dp{1},'LineStyle',dp{2},'LineWidth',dp{3});
            plot3([d(1,i+1),a(1,i+1)],[d(2,i+1),a(2,i+1)],[d(3,i+1),a(3,i+1)],'color',ap{1},'LineStyle',ap{2},'LineWidth',ap{3});
            plot3([o(1,i+1),x(1,i+1)],[o(2,i+1),x(2,i+1)],[o(3,i+1),x(3,i+1)],'color',xp{1},'LineStyle',xp{2},'LineWidth',xp{3});
            plot3([o(1,i+1),y(1,i+1)],[o(2,i+1),y(2,i+1)],[o(3,i+1),y(3,i+1)],'color',yp{1},'LineStyle',yp{2},'LineWidth',yp{3});
            plot3([o(1,i+1),z(1,i+1)],[o(2,i+1),z(2,i+1)],[o(3,i+1),z(3,i+1)],'color',zp{1},'LineStyle',zp{2},'LineWidth',zp{3});
        end
        
    end
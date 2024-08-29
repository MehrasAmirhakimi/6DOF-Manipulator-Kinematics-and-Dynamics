clear all
clc
a1 = 4;
a2 = 6;
a3 = 9;

d1 = 5;
d2 = 1;
d3 = 2;
d4 = 3;

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
          0,  0,  0, theta6];
      figure;
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
op = {'r','r','r','r','r','r','r';'o','o','o','o','o','o','o';2,2,2,2,2,2,2};
dp = {'b','b','b','b','b','b','b';'-','-','-','-','-','-','-';2,2,2,2,2,2,2};
ap = {'b','b','b','b','b','b','b';'-','-','-','-','-','-','-';2,2,2,2,2,2,2};
xp = {'c','c','c','c','m','g','k';'--','--','--','--','--','--','--';1,1,1,1,1,1,1};
yp = {'c','c','c','c','m','g','k';':',':',':',':',':',':',':';1,1,1,1,1,1,1};
zp = {'c','c','c','c','m','g','k';'-','-','-','-','-','-','-';1,1,1,1,1,1,1};
plot3(o(1,1),o(2,1),o(3,1),'color',op{1,1},'Marker',op{2,1},'LineWidth',op{3,1});
plot3([o(1,1),x(1,1)],[o(2,1),x(2,1)],[o(3,1),x(3,1)],'color',xp{1,1},'LineStyle',xp{2,1},'LineWidth',xp{3,1});
plot3([o(1,1),y(1,1)],[o(2,1),y(2,1)],[o(3,1),y(3,1)],'color',yp{1,1},'LineStyle',yp{2,1},'LineWidth',yp{3,1});
plot3([o(1,1),z(1,1)],[o(2,1),z(2,1)],[o(3,1),z(3,1)],'color',zp{1,1},'LineStyle',zp{2,1},'LineWidth',zp{3,1});
n = size(DH,1);
TT=eye;
    for i = 1:n
        alpha = DH(i, 1);
        A = DH(i, 2);
        D = DH(i, 3);
        theta = DH(i, 4);
        T(:,:,i) = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), A*cos(theta);
            sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha), A*sin(theta);
            0, sin(alpha), cos(alpha), D;
            0, 0, 0, 1];%#ok
        TT = TT*T(:,:,i);
        o = [o(:,:),[TT(1,4);TT(2,4);TT(3,4)]];
        x = [x(:,:),[TT(1,1)+TT(1,4);TT(2,1)+TT(2,4);TT(3,1)+TT(3,4)]];
        y = [y(:,:),[TT(1,2)+TT(1,4);TT(2,2)+TT(2,4);TT(3,2)+TT(3,4)]];
        z = [z(:,:),[TT(1,3)+TT(1,4);TT(2,3)+TT(2,4);TT(3,3)+TT(3,4)]];
        d =[d(:,:),D*(z(:,i)-o(:,i))+o(:,i)];
        a =[a(:,:),A*(x(:,i+1)-o(:,i+1))+d(:,i+1)];
        plot3(o(1,i+1),o(2,i+1),o(3,i+1),'color',op{1,i+1},'Marker',op{2,i+1},'LineWidth',op{3,i+1});
        plot3([o(1,i),d(1,i+1)],[o(2,i),d(2,i+1)],[o(3,i),d(3,i+1)],'color',dp{1,i+1},'LineStyle',dp{2,i+1},'LineWidth',dp{3,i+1});
        plot3([d(1,i+1),a(1,i+1)],[d(2,i+1),a(2,i+1)],[d(3,i+1),a(3,i+1)],'color',ap{1,i+1},'LineStyle',ap{2,i+1},'LineWidth',ap{3,i+1});
        plot3([o(1,i+1),x(1,i+1)],[o(2,i+1),x(2,i+1)],[o(3,i+1),x(3,i+1)],'color',xp{1,i+1},'LineStyle',xp{2,i+1},'LineWidth',xp{3,i+1});
        plot3([o(1,i+1),y(1,i+1)],[o(2,i+1),y(2,i+1)],[o(3,i+1),y(3,i+1)],'color',yp{1,i+1},'LineStyle',yp{2,i+1},'LineWidth',yp{3,i+1});
        plot3([o(1,i+1),z(1,i+1)],[o(2,i+1),z(2,i+1)],[o(3,i+1),z(3,i+1)],'color',zp{1,i+1},'LineStyle',zp{2,i+1},'LineWidth',zp{3,i+1});
    end

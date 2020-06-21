clc;

theta =  linspace(0, 3.4*2*pi, 200);

d = 0.05;
b = 1/10*1/pi;
r1 = b.*(1+theta);
x1 = r1.*cos(theta);
y1 = r1.*sin(theta);
r1b = -r1;
x1b = r1b.*cos(theta);
y1b = r1b.*sin(theta);

spiral1a=[x1;
         y1;
         ones(size(x1));];
spiral1b=[x1b;
         y1b;
         ones(size(x1));];

plot(spiral1a(1,:),spiral1a(2,:),'- r')
hold on
plot(spiral1b(1,:),spiral1b(2,:),'- r')

axis equal
spiral1a(3,:)=0;
spiral1b(3,:)=0;
writematrix(spiral1a','spiral1a.csv')
writematrix(spiral1b','spiral1b.csv')
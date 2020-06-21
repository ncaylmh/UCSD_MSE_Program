%%
%a
clear;
clf;
%%a
time = linspace(0,20,21);
angle = 2*pi*time/20;
height = [0, 2.4, 8.6, 16.4, 22.6, 25, 25, 24.9, 23.9, 21.8, 18.9,16.5, 15.2, 15, 15,12.9, 7.5, 2, 0.1, 0, 0];
plot(angle,height,'o')
axis([0,2*pi,0,25 ])

xlabel('Angle')
ylabel('Height')



%%
%b
%%lagrange
close all;
syms x_l 
data(:,1)=angle;
data(:,2)=height;
lagrange_poly = 0;
x_real = [0:0.01:2*pi];
for i=1:size(data,1)
    tmp_numerator = 1;
    tmp_denominator = 1;
    for j=1:size(data,1)
        if j ~= i
            tmp_numerator = tmp_numerator*(x_l - data(j,1));
            tmp_denominator = tmp_denominator*(data(i,1) - data(j,1));
        end
    end
    lagrange_poly = lagrange_poly + tmp_numerator/tmp_denominator * data(i,2);
end
simplify(lagrange_poly);
hold on;

axis([0, 2*pi, 0, 25])
plot(data(:,1),data(:,2),"r o")
plot(x_real, double(subs(lagrange_poly, x_l, x_real)), 'k')
xlabel('Angle')
ylabel('Follower height')
title('Lagrange fits', 'Fontweight','b')

%%
%c
% Spline & pchip
% clf;

hold on;

sp = spline(angle, height, x_real);
plot(x_real, sp, 'black');

pc = pchip(angle, height, x_real);
plot(x_real, pc, 'g');

axis([0,2*pi,0,30 ])

title('Spline fits')
xlabel('Angle')
ylabel('Follower height')

%%d
close all
clear;
clf;

time = linspace(0,20,21);
angle = 2*pi*time/20;
height = [0, 2.4, 8.6, 16.4, 22.6, 25, 25, 24.9, 23.9, 21.8, 18.9,16.5, 15.2, 15, 15,12.9, 7.5, 2, 0.1, 0, 0];

axis([0,2*pi,0,25 ])

theta = [0:0.1:2*pi];

%%
%d
%picth curve & cam surface
%(xpc,ypc) & (xps,yps)
% pchip
% clf;
hold on;

rf = 2;
rp = 10;
pc = pchip(angle, height, theta);


rpc = rp+pc;
xpc = rpc.*cos(theta);
ypc = rpc.*sin(theta);
time = 1;
dxpc = gradient(xpc)/time;
dypc = gradient(ypc)/time;
speed = sqrt(dxpc.^2+dypc.^2); 
xcs = xpc+rf.*(-dypc./speed);
ycs = ypc+rf.*(dxpc./speed);
plot(xpc, ypc, 'g--');
plot(xcs, ycs, 'black');

axis([-50,50,-50,50 ])
daspect([1,1,1])

%%
%e
%rotation
% This is an arbitrary translation matrix        
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  
% This is an arbitrary rotation matric
R = @(ro) [cos(ro),sin(ro);
           -sin(ro),cos(ro)];
% unit circle
    thetar = linspace(0, 2*pi, 1000);
    [x, y] = pol2cart(thetar, ones(size(thetar)));
    circle = [x; y; ones(size(x))];  
%Rotation
for i = 0:4
    angler = i/5*2*pi;
    pcr = R(angler)*[xpc;ypc];
    xcsr = R(angler)*[xcs;ycs];
    
    subplot(1,5,i+1);
    plot(pcr(1,:),pcr(2,:),'g--');
    hold on;
    plot(xcsr(1,:),xcsr(2,:),'black');
    title(['Theta=' num2str(i/5*2*pi) 'pi']);
    
    new_height = pchip(angle, height, angler);
    new_circle = T(new_height+rp,0)*S(2,2)*circle;
    plot(new_circle(1,:),new_circle(2,:),'r')

    axis([-50,50,-50,50 ])
    daspect([1,1,1])
end
xcsr(3,:)=0;

writematrix(xcsr','xcsr.csv')

clc
close all
clear

%% Transformers
% This is an arbitrary translation matrix        
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1]; 
% This is a rotation matrix (clockwise)
R = @(theta) [cos(theta)  sin(theta) 0;
                -sin(theta) cos(theta) 0;
                0           0          1];

            
%% a bplot 5 point star
%plot first point
pointa = [-16,1.5]';
pointb = [-15, 5]';
pointc = [-14,1.5]';
abc = [pointa pointb pointc];

%plot(abc(1,:),abc(2,:),'y - .', 'markersize',10)
%axis([-25,15,-10,15]);
%axis equal

abc3d=abc;
abc3d(3,:) =1;
star = [abc3d];

for i=1:4
    newpoint = T(-15,0)*R(i*72/180*pi)*T(15,0)*abc3d;
    star = [star, newpoint];
end
star = [star, [-16,1.5,1]']; %connect the gap
scaledstar =T(-15,0)*S(0.5,0.5)*T(15,0)*star;

%plot(star(1,:),star(2,:))
%old on
%plot(scaledstar(1,:),scaledstar(2,:))
%axis([-20, -10, -5, 5] ,'equal');

%% c
clc
curve=[];
x = [-10:0.1:10];
y = 10*exp(-(x/5).^2);
curve(1,:) =x;
curve(2,:) =y;

plot(curve(1,:),curve(2,:))
axis([-20, 20, -5, 15] ,'equal');
hold on

% Move the star in part b to the left end of the curve
star0 =  T(curve(1,1)-(-15),curve(2,1))*scaledstar;
%plot(star0(1,:),staro(2,:))
%axis([-20, 20, -5, 15] ,'equal');

% one piont coincide with nomal direction
dx = gradient(x);
dy = gradient(y);
tantheta = dy./dx;
theta = atan(tantheta);
star1 = T(x(1),y(1))*R(-theta(1))*T(-x(1),-y(1))*star0;
plot(star1(1,:),star1(2,:))
axis([-20, 20, -5, 15] ,'equal');
%% d
for i = 1:201
    starmove =T(x(i),y(i))*R(-theta(i))*T(-x(i),-y(i))*T(x(i)-x(1),y(i)-y(1))*star0;
    clf
    %plot(starmove(1,:),starmove(2,:))
    %hold on 
    %plot(curve(1,:),curve(2,:))
    %axis([-20, 20, -5, 20] )
    %daspect([1 1 1]);
    %drawnow
end
snapi =[1,51,101,141,181];
for i = 1:5
    starmove =T(x(snapi(i)),y(snapi(i)))*R(-theta(snapi(i)))*T(-x(snapi(i)),-y(snapi(i)))*T(x(snapi(i))-x(1),y(snapi(i))-y(1))*star0;
    plot(starmove(1,:),starmove(2,:),'r');
    axis([-20, 20, -5, 15],'equal' );
    hold on;
end
    plot(curve(1,:),curve(2,:));

    axis([-20, 20, -5, 20],'equal' );



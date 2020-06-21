%%
%Tansformation
clear;
clf;
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  
           
% This is an arbitrary rotation matric
R = @(ro) [cos(ro), sin(ro),0;
           -sin(ro), cos(ro),0;
           0,      0 ,1];
%%
%Fibonacci siries
f = [];
f(1) = 1;
f(2) = 1;
for i = 3:16
    f(i) = f(i-1)+f(i-2);
end

fiboarc = [];

%%
%Unit arc
thetar = linspace(0, 1/2*pi, 1000);
[x, y] = pol2cart(thetar, ones(size(thetar)));
unitarc = [x; y; ones(size(x))];
plot(unitarc(1,:),unitarc(2,:),'red');

%%
%create unit square
side = linspace(0, 1, 1000);
x1=0;
y1=side;
x2=side;
y2=0;
x3=1;
y3=side;
x4 =side;
y4 =1;
line1 = [0.*ones(size(y1));
         y1;
         ones(size(y1));];
line2 = [x2;
         0.*ones(size(x2));
         ones(size(x2));];
line3 = [1.*ones(size(y3));
         y3;
         ones(size(y3));];
line4 = [x4;
         1.*ones(size(x4));
         ones(size(x4));];
unitsquare = [line1, line2, line3, line4];
plot(unitsquare(1,:),unitsquare(2,:))
    axis([-10,10,-10,10])
    
%%
% unit arc and unit square
clf;
plot(unitarc(1,:),unitarc(2,:),'red');
hold on
plot(unitsquare(1,:),unitsquare(2,:),'blue')
axis equal

%orgin arc and orgin square
originarc = R(pi)*unitarc;
originsquare = R(pi)*unitsquare;
clf;
plot(originarc(1,:),originarc(2,:),'red');
hold on
plot(originsquare(1,:),originsquare(2,:),'blue')
axis equal

%%
% origin xy position
x =[];
y = [];
x(1) =0;
y(1) =0;
for i = 2:16
    if mod(i,2)==1 % i is odd
        x(i) = x(i-1)+((-1)^floor((i-1)/2))*(f(i)-f(i-1));
        y(i) = y(i-1);
    else % i is even
        x(i) = x(i-1);
        y(i) = y(i-1)+((-1)^(floor((i-1)/2)))*(f(i)-f(i-1));
    end
end

%%
%plot fibonacci arc and fibonacci square
clc;


fiboarc = [];
fibosquare =[];
for j = 1:16
    newarc=T(x(j),y(j))*R(-(j-1)/2*pi)*S(f(j),f(j))*originarc;
    fiboarc= horzcat(fiboarc, newarc);
    newsquare =  T(x(j),y(j))*R(-(j-1)/2*pi)*S(f(j),f(j))*originsquare;
    fibosquare = horzcat(fibosquare, newsquare);
end

plot(fibosquare(1,:),fibosquare(2,:),'b')
plot(fiboarc(1,:),fiboarc(2,:), 'r')
axis equal





clear;
clf;

time = linspace(0,20,21);
angle = 2*pi*time/20;
height = [0, 2.4, 8.6, 16.4, 22.6, 25, 25, 24.9, 23.9, 21.8, 18.9,16.5, 15.2, 15, 15,12.9, 7.5, 2, 0.1, 0, 0];

axis([0,2*pi,0,25 ])

theta = [0:0.1:2*pi];

%%
% pchip
% clf;
hold on;

rf = 2;
rp = 10;
pc = pchip(angle, height, theta);

%%
%picth curve & cam surface
%(xpc,ypc) & (xps,yps)
rpc = rp+pc;
xpc = rpc.*cos(theta);
ypc = rpc.*sin(theta);
time = 1;
dxpc = gradient(xpc);
dypc = gradient(ypc);
speed = sqrt(dxpc.^2+dypc.^2); 
xcs = xpc+rf.*(-dypc./speed);
ycs = ypc+rf.*(dxpc./speed);
plot(xpc, ypc, 'g--');
plot(xcs, ycs, 'black');

axis([-50,50,-50,50 ])
daspect([1,1,1])

%%
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


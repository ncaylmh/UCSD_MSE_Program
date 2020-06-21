clear
clc
clf
%% plot AB curve

rAB=[];
thetac =[];
for theta=pi/2:0.01:7/6*pi
    F=@(r) curveAB(r,theta);
    [r,fval]=fsolve(F,0);
    rAB=[rAB r];
    thetac =[thetac theta];
end
[xab,yab] = pol2cart(thetac,rAB);
plot(xab,yab)
axis([-3,3,-3,3],'equal')
hold on
%% plot BC curve
rBC=[];
thetaa =[];
for theta=-5*pi/6:0.01:-pi/6
    F=@(r) curveBC(r,theta);
    [r,fval]=fsolve(F,0);
    rBC=[rBC r];
    thetaa =[thetaa theta];
end
[xbc,ybc] = pol2cart(thetaa,rBC);
plot(xbc,ybc,'k')
axis([-3,3,-3,3],'equal')
hold on

%% plot AC curve
rAC=[];
thetab=[];
for theta=-pi/6:0.01:pi/2
    F=@(r) curveAC(r,theta);
    [r,fval]=fsolve(F,0);
    rAC=[rAC r];
    thetab=[thetab theta];
end
[xac,yac] = pol2cart(thetab,rAC);
plot(xac,yac)
axis([-3,3,-3,3],'equal')


clc;
clear;
c = 3e8;
h = 6.626e-34;
k = 1.38e-23;
t = 5800;
vg = 1.618e14;
Qfun = @(v) 2*(v.^2)./(c.^2)./(exp((h.*v)./(k*t))-1);
pfun = @(v) 2*h*(v.^3)./(c.^2)./(exp((h.*v)./(k*t))-1);
q = integral(Qfun,vg,3.45e14);
q
p = integral(pfun, 0 ,10e20);
p
u = q*h*vg/p;
u
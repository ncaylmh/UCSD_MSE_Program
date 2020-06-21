clear; close all; clc;

%%
% homogeneous coordinate
star = [4 1 0 -1 -5 -1  0  1 4;
        0 1 6  1  0 -1 -7 -1 0;
        1 1 1  1  1  1  1  1 1];

%% (a) plot
figure(1)
plot(star(1,:),star(2,:),'k')
xlim([-30,30])
ylim([-30,30])
axis equal
xlabel('X')
ylabel('Y')
title('Problem 3')

hold on

%% (b) 
R_b = [cosd(60) -sind(60) 0;
       sind(60) cosd(60) 0;
       0        0        1];

H_b = R_b

star_b = H_b*star;
plot(star_b(1,:),star_b(2,:),'b')

%% (c)
T_c1 = [1 0 -3;
        0 1 -3;
        0 0  1];
R_c = [cosd(-30) -sind(-30) 0;
       sind(-30)  cosd(-30) 0;
       0          0         1];
T_c2 = [1 0 3;
        0 1 3;
        0 0 1];

H_c = T_c2*R_c*T_c1

star_c = H_c*star;
plot(star_c(1,:),star_c(2,:),'g')

%% (d)
S_d = [2 0 0;
       0 4 0;
       0 0 1];
   
H_d = S_d

star_d = H_d*star;
plot(star_d(1,:),star_d(2,:),'r')

%% (e) 
Ref = [1  0 0;
       0 -1 0;
       0  0 1];

H_e = Ref

star_e = H_e*star;
plot(star_e(1,:),star_e(2,:),'m')

legend('(a)','(b)','(c)','(d)','(e)')
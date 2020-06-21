clear; close all; clc;

%% plot the body 
A = [4 6 0]';
B = [11 5 0]';
C = [3 14 0]';
D = [4 6 2]';
E = [11 5 4]';
F = [3 14 6]';

points = [A B C D E F];
points_homo = [points; ones(1,6)];

figure(1)
fill3(points(1,1:3),points(2,1:3),points(3,1:3),'b','FaceAlpha',0.5)
hold on
fill3(points(1,4:6),points(2,4:6),points(3,4:6),'g','FaceAlpha',0.5)
fill3(points(1,[1 2 5 4]),points(2,[1 2 5 4]),points(3,[1 2 5 4]),'r','FaceAlpha',0.5)
fill3(points(1,[1 3 6 4]),points(2,[1 3 6 4]),points(3,[1 3 6 4]),'m','FaceAlpha',0.5)
fill3(points(1,[2 3 6 5]),points(2,[2 3 6 5]),points(3,[2 3 6 5]),'c','FaceAlpha',0.5)

%% (a)
disp('Part(a) reflecting and scaling operators:')
% reflection

H_r = [-1 0 0 0;
        0 1 0 0;
        0 0 1 0;
        0 0 0 1]
    
points_ref = H_r * points_homo;

fill3(points_ref(1,1:3),points_ref(2,1:3),points_ref(3,1:3),'b','FaceAlpha',0.5)
fill3(points_ref(1,4:6),points_ref(2,4:6),points_ref(3,4:6),'g','FaceAlpha',0.5)
fill3(points_ref(1,[1 2 5 4]),points_ref(2,[1 2 5 4]),points_ref(3,[1 2 5 4]),'r','FaceAlpha',0.5)
fill3(points_ref(1,[1 3 6 4]),points_ref(2,[1 3 6 4]),points_ref(3,[1 3 6 4]),'m','FaceAlpha',0.5)
fill3(points_ref(1,[2 3 6 5]),points_ref(2,[2 3 6 5]),points_ref(3,[2 3 6 5]),'c','FaceAlpha',0.5)

% scaling

H_s = [4 0 0 0;
       0 4 0 0;
       0 0 4 0;
       0 0 0 1]

points_sc = H_s * points_ref;

fill3(points_sc(1,1:3),points_sc(2,1:3),points_sc(3,1:3),'b','FaceAlpha',0.5)
fill3(points_sc(1,4:6),points_sc(2,4:6),points_sc(3,4:6),'g','FaceAlpha',0.5)
fill3(points_sc(1,[1 2 5 4]),points_sc(2,[1 2 5 4]),points_sc(3,[1 2 5 4]),'r','FaceAlpha',0.5)
fill3(points_sc(1,[1 3 6 4]),points_sc(2,[1 3 6 4]),points_sc(3,[1 3 6 4]),'m','FaceAlpha',0.5)
fill3(points_sc(1,[2 3 6 5]),points_sc(2,[2 3 6 5]),points_sc(3,[2 3 6 5]),'c','FaceAlpha',0.5)

xlabel('X position')
ylabel('Y position')
zlabel('Z position')
axis equal
grid on
%%
view(-30,15)

%% (b)
theta = -120;
% let the projection on xy plane be 1
L_xy = 1;

L_x = L_xy*cosd(60);
L_y = L_xy*sind(60);
L_z = L_y*tand(60);

L_axis = sqrt(L_x^2 + L_y^2 + L_z^2);


ux = L_x/L_axis;
uy = L_y/L_axis;
uz = L_z/L_axis;

disp('Part(b) rotation operators:')

H_rt = [cosd(theta)+ux^2*(1-cosd(theta)), ux*uy*(1-cosd(theta))-uz*sind(theta), ux*uz*(1-cosd(theta))+uy*sind(theta), 0;
     uy*ux*(1-cosd(theta))+uz*sind(theta), cosd(theta)+uy^2*(1-cosd(theta)), uy*uz*(1-cosd(theta))-ux*sind(theta), 0;
     uz*ux*(1-cosd(theta))-uy*sind(theta), uz*uy*(1-cosd(theta))+ux*sind(theta), cosd(theta)+uz^2*(1-cosd(theta)), 0;
     0,                                    0,                                    0,                                1]

points_rt = H_rt * points_homo;

figure(2)
clf
fill3(points(1,1:3),points(2,1:3),points(3,1:3),'b','FaceAlpha',0.5)
hold on
fill3(points(1,4:6),points(2,4:6),points(3,4:6),'g','FaceAlpha',0.5)
fill3(points(1,[1 2 5 4]),points(2,[1 2 5 4]),points(3,[1 2 5 4]),'r','FaceAlpha',0.5)
fill3(points(1,[1 3 6 4]),points(2,[1 3 6 4]),points(3,[1 3 6 4]),'m','FaceAlpha',0.5)
fill3(points(1,[2 3 6 5]),points(2,[2 3 6 5]),points(3,[2 3 6 5]),'c','FaceAlpha',0.5)

fill3(points_rt(1,1:3),points_rt(2,1:3),points_rt(3,1:3),'b','FaceAlpha',0.5)
fill3(points_rt(1,4:6),points_rt(2,4:6),points_rt(3,4:6),'g','FaceAlpha',0.5)
fill3(points_rt(1,[1 2 5 4]),points_rt(2,[1 2 5 4]),points_rt(3,[1 2 5 4]),'r','FaceAlpha',0.5)
fill3(points_rt(1,[1 3 6 4]),points_rt(2,[1 3 6 4]),points_rt(3,[1 3 6 4]),'m','FaceAlpha',0.5)
fill3(points_rt(1,[2 3 6 5]),points_rt(2,[2 3 6 5]),points_rt(3,[2 3 6 5]),'c','FaceAlpha',0.5)

plot3([0, 10*L_x],[0 10*L_y],[0 10*L_z],'r--','linewidth',2)

xlabel('X position')
ylabel('Y position')
zlabel('Z position')
axis equal
grid on
view(60,15)



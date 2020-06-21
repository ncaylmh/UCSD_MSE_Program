
%% How we start all scripts

clc;
close all;
clear;


%% Let's make a fun shape!

point0 = [0, 0]';
point1 = [1, 0]';
point2 = [0.25, 0.25]';
point3 = [0, 1]';
point4 = [-0.25, 0.25]';
point5 = [-1, 0]';
point6 = [-0.25, -0.25]';
point7 = [0, -1]';
point8 = [0.25, -0.25]';
point9 = point1;
    


points = [point0 point1 point2 point3 ...
          point4 point5 point6 point7 ...
          point8 point9];

%% Let's plot!

plot(points(1,:), points(2,:), '-o')
axis([-10, 10, -10, 10], 'equal');

%% Let's also define an inline function to plot these points

plot_points = @(list_of_points) plot(list_of_points(1,:), list_of_points(2,:), '-o');

%% Let's scale this shape, we can try a couple different Sx and Sy values
clf;

Sx = 5;
Sy = 5;

S = [Sx, 0; 
     0,  Sy];
 
scaled_points = S*points;

plot_points(points);
hold on;
plot_points(scaled_points);
axis([-10, 10, -10, 10], 'equal');


 
%% This scaling works great, but if we want to translate and scale


Sx = 6;
Sy = 2;

S = [Sx, 0; 
     0,  Sy];

T = [3, 5]';

scaled_points = S*points + T;    %!!!!!!! THIS IS NEW TO MATLAB -- BROADCASTING

clf;
plot_points(points);
hold on;
plot_points(scaled_points);
axis([-10, 10, -10, 10], 'equal');

%% But, chaining multiple translations and scaling operations is tiresome

scaled_points = (S/10)*(S/6)*S*points + T - T/2 + T/4;

clf;
plot_points(points);
hold on;
plot_points(scaled_points);
axis([-10, 10, -10, 10], 'equal');


%% Combinations of translation and rotation are much better handled with 
%  homogeneous coordinates. In this case the last matrix column represents
%  translations, and then all combinations of affine transformations can be
%  represented by chain multiplication of matrices

% first we represent all [x,y]' vectors as [x, y, 1]'
h_points = points;
h_points(3,:) = 1

% build translation matrix
Tx = -5;
Ty = 4;

h_T = [eye(3,2) [Tx Ty 1]']

scaled_points = h_T*h_points;

clf;
plot_points(points);
hold on;
plot_points(scaled_points);
axis([-10, 10, -10, 10], 'equal');

%% Test out scaling

% build scale matrix
Sx = 6;
Sy = 6;

S = [Sx, 0; 
     0,  Sy];
 
h_S = S;
h_S(3,3) = 1

scaled_points = h_S*h_points;

clf;
plot_points(points);
hold on;
plot_points(scaled_points);
axis([-10, 10, -10, 10], 'equal');

%% Now combine scaling and translation

h_ST = h_T*h_S;   % !!!!!! WHY DOES TRANSLATION COME AFTER SCALING?

scaled_points = h_ST*h_points;

clf;
plot_points(points);
hold on;
plot_points(scaled_points);
axis([-10, 10, -10, 10], 'equal');


%% Rotation

theta = 60*pi/180;

h_R = [cos(theta)  sin(theta) 0;
       -sin(theta) cos(theta) 0;
       0           0          1];
   
scaled_points = h_R*h_points;

clf;
plot_points(points);
hold on;
plot_points(scaled_points);
axis([-3, 3, -3, 3], 'equal');

%% Let's make a pretty animation


for theta = 0:0.01:10pi;

    h_R = [cos(theta)  sin(theta) 0;
           -sin(theta) cos(theta) 0;
           0           0          1];

    scaled_points = h_R*h_points;

    clf;
    plot_points(points);
    hold on;
    plot_points(scaled_points);
    axis([-3, 3, -3, 3], 'equal');
    drawnow;
end


%% At this point let me define some helper one-liner functions

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];         
           
% This is an arbitrary translation matrix        
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary (2D) rotation matrix
R = @(theta) [cos(theta)  sin(theta) 0;
              -sin(theta) cos(theta) 0;
              0           0          1];

%% Example usage

clf;
plot_points(h_points);
hold on;
plot_points(T(5,4)*h_points);

plot_points(T(-5,4)*S(3,1)*h_points);

plot_points(T(-5,-4)*R(20*pi/180)*S(1,3)*h_points);

axis([-10, 10, -10, 10], 'equal');

%% Rotation about a point not at the origin
clf;
% let's generate a new shape not at the origin
new_shape = T(-5,-4)*R(20*pi/180)*S(1,3)*h_points;
plot_points(new_shape);
hold on;
plot_points(h_points);

axis([-10, 10, -10, 10], 'equal');

% pause
% now what if I want to scale or rotate this shape around it's origin?
shape_center = [-5, -4, 1]';

% To rotate about this point we have to translate back to the origin, 
% rotate, and then translate back to the current center

rotated_new_shape = T(shape_center(1), shape_center(2))*R(20*pi/180)*T(-shape_center(1), -shape_center(2))*new_shape;
plot_points(rotated_new_shape);


%% Let's make a pretty animation of this rotation about a  non-origin point


for theta = 0:0.01:10*pi
    theta
    clf;
    plot_points(h_points);
    hold on;
    plot_points(new_shape);
    
    rotated_new_shape = T(shape_center(1), shape_center(2))*R(theta)*T(-shape_center(1), -shape_center(2))*new_shape;
    plot_points(rotated_new_shape);
    
    axis equal;
    axis([-10, 10, -10, 10]);
    drawnow;
end


%% What about for an arbitrary shape??
clf;
axis equal;
axis([-10, 10, -10, 10]);

my_points = [];

while true
    new_point = ginput(1);    % ginput allows us to input points by clicking
    if isempty(new_point)     % If no points are selected we break
        break
    end
    
    my_points(:,end+1) = [new_point 1]';  % Add the next point to the matrix
    
    clf;
    plot_points(my_points);
    axis equal;
    axis([-10, 10, -10, 10]);

end

my_points(:,end+1) = my_points(:,1);


%% Lol, fun with shapes

for theta = 0:0.01:10*pi;
    theta
    clf;
    plot_points(my_points);
    hold on;
    plot(shape_center(1), shape_center(2),'ro');
    
    rotated_new_shape = T(shape_center(1), shape_center(2))*R(theta)*T(-shape_center(1), -shape_center(2))*my_points;
    plot_points(rotated_new_shape);
    
    axis equal;
    axis([-10, 10, -10, 10]);
    drawnow;
end


%% Metamaterials example
clf;
% make a circle
theta = linspace(-0.25*pi, .75*pi, 100);
[x, y] = pol2cart(theta, ones(size(theta)));

circle = [x; y; ones(size(x))];

plot_points(circle);
hold on
axis([-4, 4, -4, 4], 'equal');

% squash it a bit
squashed = S(1, 0.7)*circle;
plot_points(squashed);
axis equal;
axis([-4, 4, -4, 4], 'equal');

%% Now lets make an array of these shapes with a sinusoidal gradient in size, and 
%  an linearly decreasing gradient in angle. 
clf;

v_scale = 3;              % vertical scale
h_scale = 3.5;            % horizontal offset
lambda = .3;               % sinusoidal scale
Nx = 100;                  % number of points
Ny = 40;                  % number of points
sc = 0.5;

array = squashed;
for ii = 1:Nx
    array = horzcat(array, T(ii*h_scale, 0)*S(1+sc*sin(ii/(Nx*lambda)*2*pi), ...
                           1+sc*sin(ii/(Nx*lambda)*2*pi))*R(ii*(pi/4)/Nx)*squashed);
end

vertical_array = array;
for ii = 1:Ny
    vertical_array = horzcat(vertical_array, T(0, ii*v_scale)*array);
end

plot(vertical_array(1,:), vertical_array(2,:), '.')
axis equal;

               sxtotal+(ii-1)*h_scale))/2
               (sxtotal+(ii-1)*h_scale)


























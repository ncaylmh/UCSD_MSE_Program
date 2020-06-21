plot_points = @(list_of_points) plot(list_of_points(1,:), list_of_points(2,:), 'black');

% This is an arbitrary translation matrix
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  

%% circle array example
clf;
% make a circle
theta = linspace(0, 2*pi, 1000);
[x, y] = pol2cart(theta, ones(size(theta)));
circle = [x; y; ones(size(x))];



% sclaing the shape of circle
%squashed = S(1, 0.7)*circle;
%plot_points(squashed);
%axis equal;
%axis([-4, 4, -4, 4], 'equal');

%% Now lets make an array of these shapes with a sinusoidal gradient in size, and 
%  an linearly decreasing gradient in angle. 
clc;clf;

v_scale = 1;              % vertical scale
h_scale = 2;            % horizontal offset
%lambda = .3;              % sinusoidal scale
Nx = 6;                 % number of points
%Ny = 4;                  % number of points
%sc = 0.5;
s = [1, 6, 11, 16, 21, 26];

plot(array(1,:), array(2,:), '.')


clf;
for i = 1:Nx
    sx = 1;
    sy = 1;
    sxtotal = 0;
    sd = 0;
               
    %x translation
    for ii = 1:(i-1)
        sd = sd+s(ii);
    end    
    sxtotal =  s(i)/2 - s(1)/2+sd;

    new_circle = T(((sxtotal+(i-1)*h_scale)), s(i)/2)*S(s(i)/2, s(i)/2)*circle;
    
    array = horzcat(array, new_circle);
    
    %y translation
    j=1;
    while(j< idivide(48, int16(s(i)+1),'floor'))
        new_circle1 = T(0, j*(v_scale+s(i)))*new_circle;
        array = horzcat(array, new_circle1);
        j = j+1
    end
               
end

plot(array(1,1001:end), array(2,1001:end), '.')

rectangle('Position',[-5,-1,100,50]) 


axis([-10, 120, -10, 60], 'equal');



plot_points = @(list_of_points) plot(list_of_points(1,:), list_of_points(2,:), 'black');

% This is an arbitrary translation matrix        
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  

%% 
clf;
% make a circle
theta = linspace(0, 2*pi, 1000);
[x, y] = pol2cart(theta, ones(size(theta)));
circle = [x; y; ones(size(x))];



% squash it a bit
%squashed = S(1, 0.7)*circle;
%plot_points(squashed);
%axis equal;
%axis([-4, 4, -4, 4], 'equal');

%%  

clc;clf;

v_scale = 1;              % vertical scale
h_scale = 2;            % horizontal offset

d = [1, 6, 11, 16, 21, 26];
array = [];


clf;
for i = 1:6
    sx = 1;
    sy = 1;
    dxtotal = 0;
    sd = 0;
    arrayy=[];
    for ii = 1:(i-1)
        sd = sd+d(ii);
    end    
    dxtotal =  d(i)/2 - d(1)/2+sd;
    
    new_circle = T(((dxtotal+(i-1)*h_scale)), d(i)/2)*S(d(i)/2, d(i)/2)*circle;
    

    arrayy = horzcat(arrayy, new_circle);
    j=1;
    sumy = mean(new_circle(2,:));
 
    while(j< idivide(49, int16(d(i)+1),'floor'))
        new_circle1 = T(0, j*(v_scale+d(i)))*new_circle;
        arrayy = horzcat(arrayy, new_circle1);
        j = j+1;
        sumy = sumy +mean(new_circle1(2,:));
    end
    
    yavg = sumy/j;
    arrayy(2,:) = arrayy(2,:)  +25-yavg;
    array = horzcat(array, arrayy);
end


plot(array(1,:), array(2,:), '.')

rectangle('Position',[-5,0,100,50]) 


axis([-10, 120, -10, 60], 'equal');



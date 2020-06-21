clc;
close all;
clear;

theta = linspace(0, 2*pi, 1000); 
[x, y] = pol2cart(theta, ones(size(theta)));
circle = [x; y; ones(size(x))];

T = @(tx, ty) [eye(3,2) [tx ty 1]'];
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  
R = @(theta) [cos(theta)  sin(theta) 0;
              -sin(theta) cos(theta) 0;
              0           0          1];
          
array = [];
d = [1, 6, 11, 16, 21, 26];
trans_x = 0;

for i = 1:6
    array_c = [];
    if (i == 1)
        trans_x = d(i)+trans_x;
    else
        trans_x = 4+d(i)+d(i-1)+trans_x;
    end
    new_circle = T((trans_x+2)/2, d(i)+2)*S(d(i)/2, d(i)/2)*circle;
    array_c = horzcat(array_c, new_circle);
    j = 1;
    sum = mean(new_circle(2,:));
    while(j< idivide(49, int16(d(i)+1),'floor'))
        new_circle_y = T(0, j*(2+d(i)))*new_circle;
        array_c = horzcat(array_c, new_circle_y);
        j = j+1;
        sum = sum + mean(new_circle_y(2,:));
    end
    
    avg = sum/j;
    array_c(2,:) = array_c(2,:)+25-avg;
    array = [array array_c];
end


rectangle('Position',[0 0 100 50]) 
hold on;

plot(array(1,:), array(2,:), '.')
axis ([0 100 0 50], 'equal');
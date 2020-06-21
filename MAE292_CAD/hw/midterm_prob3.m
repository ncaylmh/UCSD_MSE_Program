%% Problem 3. 
clear; clc; close all;

% data

x = 0:1:19;
y = [0.13, 3.02, 6.29, 6.52, 6.52, 7.21, 8.20, 11.39, 12.84, 14.66, 15.50, ...
     15.43, 15.05, 13.52, 10.71, 8.96, 8.50, 8.27, 8.20, 8.42];
%% Part 2

% Lagrange polys

syms x_l
lagrange_poly = 0;
for kk=1:length(x)    
    tmp_numerator = 1;    
    tmp_denominator = 1;    
    for jj=1:length(x)        
        if jj ~= kk            
            tmp_numerator = tmp_numerator*(x_l - x(jj)); 
            tmp_denominator = tmp_denominator*(x(kk) - x(jj));
        end
    end
    lagrange_poly = lagrange_poly + tmp_numerator/tmp_denominator * y(kk);
end
% simplify(lagrange_poly);

xi = 0:0.01:19;
y_poly = double(subs(lagrange_poly, x_l, xi));

%% plot
clf;
plot(x, y, 'ro');
hold on;
plot(xi, y_poly, 'k');
axis([0, 20, -5, 20]);
title('Lagrange fit');
xlabel('X');
ylabel('Y');

%% Part 3

% linear interpolation
y_line = interp1(x,y,xi);

% overshoot
SSE_pl = mean((y_poly - y_line).^2);

%% Part 4

% spline
y_sp = spline(x, y, xi);

% plot
clf;
plot(x, y, 'ro');
hold on;
plot(xi, y_sp, 'k');
axis([0, 20, -5, 20]);
title('Spline fits');
xlabel('X');
ylabel('Y');

% overshoot
SSE_sp = mean((y_sp - y_line).^2);

%% Part 5

% reflection
xy = [x; y; ones(1,20)];

T_flip =[-1 0 0; 0 -1 0; 0 0 1];

xy_left = T_flip*xy;
xy_right = T_flip*xy;

dxdy_left = xy(:,1) - xy_left(:,1);
dxdy_right = xy(:,end) - xy_right(:,end);

T_left = eye(3);
T_left(:,3) = T_left(:,3) + dxdy_left;

T_right = eye(3);
T_right(:,3) = T_right(:,3) + dxdy_right;

xy_left = T_left*xy_left;
xy_right = T_right*xy_right;

% plot
clf
plot(xy(1,:),xy(2,:),'ko')
hold on
plot(xy_left(1,2:end),xy_left(2,2:end),'bo')
plot(xy_right(1,1:end-1),xy_right(2,1:end-1),'bo')

axis([-20, 40, -20, 20]);
title('Reflection');
xlabel('X');
ylabel('Y');

% new data
xx = [fliplr(xy_left(1,2:end)),xy(1,:),fliplr(xy_right(1,1:end-1))];
yy = [fliplr(xy_left(2,2:end)),xy(2,:),fliplr(xy_right(2,1:end-1))];

%% Part 6
syms x_2
lagrange_poly_2 = 0;
for kk=1:length(xx)    
    tmp_numerator = 1;    
    tmp_denominator = 1;    
    for jj=1:length(xx)        
        if jj ~= kk            
            tmp_numerator = tmp_numerator*(x_2 - xx(jj)); 
            tmp_denominator = tmp_denominator*(xx(kk) - xx(jj));
        end
    end
    lagrange_poly_2 = lagrange_poly_2 + tmp_numerator/tmp_denominator * yy(kk);
end

y_poly_2 = double(subs(lagrange_poly_2, x_2, xi));
y_line_2 = interp1(xx,yy,xi);
y_sp_2 = spline(xx, yy, xi);

SSE_pl_2 = mean((y_poly_2 - y_line_2).^2);
SSE_sp_2 = mean((y_sp_2 - y_line_2).^2);

%% plot
plot(xi, y_poly_2, 'k');

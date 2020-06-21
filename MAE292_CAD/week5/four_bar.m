

%% Start anew

clear
clc
close all

%% Define geometry

theta_2 = pi/2;
l1 = 2;
l2 = 1;
l3 = 2; 
l4 = 1;

%% Set up the problem symbolically

% define variables
syms theta_3_sym theta_4_sym

assume(theta_3_sym, 'real');
assume(theta_4_sym, 'real');

assume(theta_3_sym >= 0 & theta_3_sym < 2*pi)
assume(theta_4_sym >= 0 & theta_4_sym < 2*pi)

% define constraint equations
A = l2*cos(theta_2) + l3*cos(theta_3_sym) - l4*cos(theta_4_sym) - l1;
B = l2*sin(theta_2) + l3*sin(theta_3_sym) - l4*sin(theta_4_sym);

%% Solve symbolically

sol1 = solve([A==0, B==0], [theta_3_sym, theta_4_sym]);

theta_3 = eval(sol1.theta_3_sym)
theta_4 = eval(sol1.theta_4_sym)

% two solutions

%% Let's see the solution(s)!!!

ii = 1;

l1_vec = [l1, 0];
l2_vec = [l2*cos(theta_2), l2*sin(theta_2)];
l3_vec = l2_vec + [l3*cos(theta_3(ii)), l3*sin(theta_3(ii))];
l4_vec = l1_vec + [l4*cos(theta_4(ii)), l4*sin(theta_4(ii))]; % -x because epsilon wrt interior angle


clf;

plot([0, l1_vec(1)], [0, l1_vec(2)], 'o-', 'linewidth', 3); % link1
hold on;
plot([0, l2_vec(1)], [0, l2_vec(2)], 'o-', 'linewidth', 3); % link2
plot([l2_vec(1), l3_vec(1)], [l2_vec(2), l3_vec(2)], 'o-', 'linewidth', 3); % link3
plot([l1_vec(1), l4_vec(1)], [l1_vec(2), l4_vec(2)], 'o-', 'linewidth', 3); % link4


axis(1.5*[-1, 1, -1, 1]);
axis equal;


%% Let's look at an animation!!

% Original geometry
% l1 = 2;
% l2 = 1;
% l3 = 2; 
% l4 = 1;

% test something else
l1 = 2;
l2 = 1;
l3 = 2; 
l4 = 1.5;

input_angle = [];
output_angle = [];


for theta_2 = 0:0.1:100000
    
    a = mod(theta_2, 2*pi);
    
    % define constraint equations
    A = l2*cos(theta_2) + l3*cos(theta_3_sym) - l4*cos(theta_4_sym) - l1;
    B = l2*sin(theta_2) + l3*sin(theta_3_sym) - l4*sin(theta_4_sym);

    %% Solve symbolically

    sol1 = solve([A==0, B==0], [theta_3_sym, theta_4_sym]);

    theta_3 = eval(sol1.theta_3_sym);
    theta_4 = eval(sol1.theta_4_sym);

    %% plot
    ii=1;
    l1_vec = [l1, 0];
    l2_vec = [l2*cos(theta_2), l2*sin(theta_2)];
    l3_vec = l2_vec + [l3*cos(theta_3(ii)), l3*sin(theta_3(ii))];
    l4_vec = l1_vec + [l4*cos(theta_4(ii)), l4*sin(theta_4(ii))]; % -x because epsilon wrt interior angle


    clf;

    plot([0, l1_vec(1)], [0, l1_vec(2)], 'o-', 'linewidth', 3); % link1
    hold on;
    plot([0, l2_vec(1)], [0, l2_vec(2)], 'o-', 'linewidth', 3); % link2
    plot([l2_vec(1), l3_vec(1)], [l2_vec(2), l3_vec(2)], 'o-', 'linewidth', 3); % link3
    plot([l1_vec(1), l4_vec(1)], [l1_vec(2), l4_vec(2)], 'o-', 'linewidth', 3); % link4
    
    input_angle(end+1) = a;
    output_angle(end+1, 1:2) = theta_4;

    axis equal;
    axis(3.5*[-1, 1, -1, 1]);
    
    drawnow;
    
end

%% Solve numerically with fsolve

theta_2 = 1.3*pi/4;
l1 = 1;
l2 = 2;
l3 = 1;
l4 = 2;

F = @(x) four_bar_constraint(x, theta_2, l1, l2, l3, l4)

[x,fval] = fsolve(F, [0, 0]);

theta_3 = x(1)
theta_4 = x(2)

% Let's see the solution!!!

ii=1;
l1_vec = [l1, 0];
l2_vec = [l2*cos(theta_2), l2*sin(theta_2)];
l3_vec = l2_vec + [l3*cos(theta_3(ii)), l3*sin(theta_3(ii))];
l4_vec = l1_vec + [l4*cos(theta_4(ii)), l4*sin(theta_4(ii))]; % -x because epsilon wrt interior angle


clf;

plot([0, l1_vec(1)], [0, l1_vec(2)], 'o-', 'linewidth', 3); % link1
hold on;
plot([0, l2_vec(1)], [0, l2_vec(2)], 'o-', 'linewidth', 3); % link2
plot([l2_vec(1), l3_vec(1)], [l2_vec(2), l3_vec(2)], 'o-', 'linewidth', 3); % link3
plot([l1_vec(1), l4_vec(1)], [l1_vec(2), l4_vec(2)], 'o-', 'linewidth', 3); % link4


axis equal;
axis(3.5*[-1, 1, -1, 1]);


%% Let's look at an animation!!

% Original
l1 = 2;
l2 = 1;
l3 = 2;
l4 = 1.2;


% l1 = 1;
% l2 = 2;
% l3 = .5;
% l4 = 1;

x_guess = [0, 0];


omega = 1;

for t = 0:0.1:100000
    
    theta_2 = mod(omega*t, 2*pi);
    
    %% Solve numerically
    
    [x,fval] = fsolve(@(x) four_bar_constraint(x, theta_2, l1, l2, l3, l4), [0, 0]);

    theta_3 = x(1);
    theta_4 = x(2);
    
    
    % Only plot solutions that satisfy a certain final tolerance
    if norm(fval) < 0.000001
        %% plot

        l1_vec = [l1, 0];
        l2_vec = [l2*cos(theta_2), l2*sin(theta_2)];
        l3_vec = l2_vec + [l3*cos(theta_3), l3*sin(theta_3)];
        l4_vec = l1_vec + [l4*cos(theta_4), l4*sin(theta_4)]; % -x because epsilon wrt interior angle


        clf;

        plot([0, l1_vec(1)], [0, l1_vec(2)], 'o-', 'linewidth', 3); % link1
        hold on;
        plot([0, l2_vec(1)], [0, l2_vec(2)], 'o-', 'linewidth', 3); % link2
        plot([l2_vec(1), l3_vec(1)], [l2_vec(2), l3_vec(2)], 'o-', 'linewidth', 3); % link3
        plot([l1_vec(1), l4_vec(1)], [l1_vec(2), l4_vec(2)], 'o-', 'linewidth', 3); % link4



        axis equal;
        axis(3.5*[-1, 1, -1, 1]);

        drawnow;
    end
    
    
%     pause;
end


%% Now lets pre-seed the solution and store the results to plot

% Original
l1 = 2;
l2 = 1;
l3 = 2;
l4 = 1.2;


% l1 = 1;
% l2 = 2;
% l3 = .5;
% l4 = 1;

x_guess = [0, 0];

input_angle = 0;
output_angle = 0;
cnt = 1;

omega = 1;

for t = 0:0.1:100000
    
    theta_2 = mod(omega*t, 2*pi);
    
    %% Solve numerically
    
    [x,fval] = fsolve(@(x) four_bar_constraint(x, theta_2, l1, l2, l3, l4), [0, output_angle(end)]);

    theta_3 = x(1);
    theta_4 = x(2);
    
    input_angle(cnt) = theta_2;
    output_angle(cnt) = theta_4;
    cnt = cnt + 1;
    
    
    % Only plot solutions that satisfy a certain final tolerance
    if norm(fval) < 0.000001
        %% plot

        l1_vec = [l1, 0];
        l2_vec = [l2*cos(theta_2), l2*sin(theta_2)];
        l3_vec = l2_vec + [l3*cos(theta_3), l3*sin(theta_3)];
        l4_vec = l1_vec + [l4*cos(theta_4), l4*sin(theta_4)]; % -x because epsilon wrt interior angle


        clf;

        plot([0, l1_vec(1)], [0, l1_vec(2)], 'o-', 'linewidth', 3); % link1
        hold on;
        plot([0, l2_vec(1)], [0, l2_vec(2)], 'o-', 'linewidth', 3); % link2
        plot([l2_vec(1), l3_vec(1)], [l2_vec(2), l3_vec(2)], 'o-', 'linewidth', 3); % link3
        plot([l1_vec(1), l4_vec(1)], [l1_vec(2), l4_vec(2)], 'o-', 'linewidth', 3); % link4



        axis equal;
        axis(3.5*[-1, 1, -1, 1]);

        drawnow;
    end
    
    
%     pause;
end

%% Three point motion synthesis



%% Let's add a coupler

% First some helper functions
% This is an arbitrary translation matrix        
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary (2D) rotation matrix
R = @(theta) [cos(theta)  sin(theta) 0;
              -sin(theta) cos(theta) 0;
              0           0          1];


% Good rocker crank 
l1 = 2;
l2 = 1;
l3 = 2;
l4 = 1.5;      
          
% rocker rocker
% l1 = 1.11;
% l2 = 1.3;
% l3 = 1.5;
% l4 = 1.5;

% Another good one
% l1 = .4;
% l2 = 1.;
% l3 = 1.7;
% l4 = 1.5;


% Good double rocker
% l1 = 2;
% l2 = 1.2;
% l3 = 1.;
% l4 = 1.5;




% Define the coupler in homogeneous coords wrt ground axis 
coupler = [0, .2; 
           0, .6; 
           1, 1];

% coupler = [0, 0; 
%            0, 0; 
%            1, 1];



% Viewing scale
sc = 5.2;
      
xy_points = [];
x_guess = [0, 0];

% set up driving angle and step and direction. Do this so we can reverse
% direction when we hit a limit
alpha = 0;
direction = 1;
alphastep = 0.1;

% Assume we haven't found a solution initially
found_solution = 0;  

tolerance = 0.0001; % This is a tolerance specified for the solver to reach

theta_2 = 0;
[x_prev,fval] = fsolve(@(x) four_bar_constraint(x, theta_2, l1, l2, l3, l4), [0, 0]);

theta_3 = x_prev(1);
theta_4 = x_prev(2);


for count= 0:1:10000
    
    
    theta_2 = mod(alpha, 2*pi);
    
    %% Solve numerically
    
    [x,fval] = fsolve(@(x) four_bar_constraint(x, theta_2, l1, l2, l3, l4), [x_prev(1), x_prev(2)]);
    
    ang_change = norm(x - x_prev);

    if norm(fval) < 0.001
        x_prev = x;
        
        theta_3 = x(1);
        theta_4 = x(2);
    
        found_solution = 1;
        %% plot

        l1_vec = [l1, 0];
        l2_vec = [l2*cos(theta_2), l2*sin(theta_2)];
        l3_vec = l2_vec + [l3*cos(theta_3), l3*sin(theta_3)];
        l4_vec = l1_vec + [l4*cos(theta_4), l4*sin(theta_4)]; 
        
        clf;
        plot([0, l1_vec(1)], [0, l1_vec(2)], 'o-', 'linewidth', 3); % link1
        hold on;
        plot([0, l2_vec(1)], [0, l2_vec(2)], 'o-', 'linewidth', 3); % link2
        plot([l2_vec(1), l3_vec(1)], [l2_vec(2), l3_vec(2)], 'o-', 'linewidth', 3); % link3
        plot([l1_vec(1), l4_vec(1)], [l1_vec(2), l4_vec(2)], 'o-', 'linewidth', 3); % link4
        
        
        coupler_new = T(l2_vec(1), l2_vec(2))*R(-theta_3)*coupler;
        coupler_xy = [coupler_new(1,2), coupler_new(2,2)];
        
        xy_points(end+1,1) = coupler_xy(1);
        xy_points(end,2) = coupler_xy(2);
                
        % plot the coupler
        plot([coupler_new(1,1), coupler_new(1,2)], [coupler_new(2,1), coupler_new(2,2)], 'ko-', 'linewidth', 3);
        plot([coupler_new(1,2), l4_vec(1)], [coupler_new(2,2), l4_vec(2)], 'ko-', 'linewidth', 3);
        
        plot(xy_points(:,1), xy_points(:,2),'k');

        axis equal;
        axis(sc*[-1, 1, -1, 1]);

        drawnow;
    else % we hit the limit of the four bar, reverse direction

        direction = -direction;
%         direction
    
    end
    
    alpha = alpha + alphastep*direction;
    
    
%     pause;
end














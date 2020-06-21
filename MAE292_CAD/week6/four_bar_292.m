

%% Define constants

t = 0.25;
w = 0.6;

L1 = 5;
L2 = 3;
L3 = 5;
L4 = 6;


%% Define a series of positions to move through
t_end = 2*pi; % run for 10 seconds


omega = 1;
time = linspace(0, t_end, 50);
theta = time*omega + pi/2;
input_link_angle = [time', theta'];


%% Simulate

simOut = sim('four_bar_292',... 
             'SimulationMode','normal', ...
             'AbsTol','1e-5', ...
             'StartTime', '0', ...
             'StopTime', num2str(t_end));


tout = simOut.tout;
simout = simOut.simout;

input_angle = simout(:,2);
torque = simout(:,1);
%% Inspect the results

idx = 1:length(input_angle);

subplot(2,1,1)
plot(tout(idx), input_angle(idx));

subplot(2,1,2);
plot(tout(idx), torque(idx));

%% Inspect the results

clf
plot(input_angle, torque);


%% add a coupler point

L5 = 3;
coupler_angle = 90;

%% Run with the coupler

simOut = sim('four_bar_292_optim',... 
             'SimulationMode','normal', ...
             'AbsTol','1e-5', ...
             'StartTime', '0', ...
             'StopTime', num2str(t_end));


tout = simOut.tout;
simout = simOut.simout;

input_angle = simout(:,2);
torque = simout(:,1);

coupler_x = simout(:,3);
coupler_y = simout(:,4);

%% Inspect the results

plot(coupler_x, coupler_y);
axis equal;

%% run a parameter sweep

c_x = [];
c_y = [];
cnt = 1;

for l2 = 1:0.1:4.5

    L2 = l2;

    simOut = sim('four_bar_292_optim',... 
                 'SimulationMode','normal', ...
                 'AbsTol','1e-5', ...
                 'StartTime', '0', ...
                 'StopTime', num2str(t_end));

    tout = simOut.tout;
    simout = simOut.simout;

    input_angle = simout(:,2);
    torque = simout(:,1);

    coupler_x = simout(:,3);
    coupler_y = simout(:,4);

    c_x(:, cnt) = coupler_x;
    c_y(:, cnt) = coupler_y;
    cnt = cnt + 1
    
end

%% Plot results
clf;
plot(c_x, c_y)
axis equal
title('Coupler curves for range of input link length l2');





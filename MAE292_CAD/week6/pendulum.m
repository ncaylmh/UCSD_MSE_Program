

%% Define constants

t = 0.25;
w = 0.6;

L2 = 2;
L3 = 5;

%%
t_end = 10; % stop after 10 seconds
simOut = sim('pendulum',... 
             'SimulationMode','normal', ...
             'AbsTol','1e-5', ...
             'RelTol','1e-5', ...
             'StartTime', '0', ...
             'StopTime', num2str(t_end));


time = simOut.tout;
positions = simOut.simout;

%%

plot(time, positions)
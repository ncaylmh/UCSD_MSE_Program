
%%

inch2m = 1/20.54;

L1 = 3*inch2m;
L2 = 7*inch2m;
L3 = 9*inch2m;
R = 12.5*inch2m;
L5 = 10*inch2m;
d = 7*inch2m;

w = 1*inch2m;
t = 0.2*inch2m;

theta = 35;

%%
omega = 1;

time = linspace(0,10,100);
q = omega*time + pi/2;

qq = [time; q]';

%%

theta = 35;
dat1 = sim('hw4_piston','SimulationMode','normal', ...
            'AbsTol','1e-5', 'StartTime', '0',...
            'StopTime', num2str(time(end)));
        
theta = 45;
dat2 = sim('hw4_piston','SimulationMode','normal', ...
            'AbsTol','1e-5', 'StartTime', '0',...
            'StopTime', num2str(time(end)));
        
theta = 55;
dat3 = sim('hw4_piston','SimulationMode','normal', ...
            'AbsTol','1e-5', 'StartTime', '0',...
            'StopTime', num2str(time(end)));    
        
theta = 65;
dat4 = sim('hw4_piston','SimulationMode','normal', ...
            'AbsTol','1e-5', 'StartTime', '0',...
            'StopTime', num2str(time(end)));         

%% Part a plot
clf;
plot(dat1.simout(:,1), dat1.simout(:,2)/inch2m);
hold on;
plot(dat1.simout(:,1), dat2.simout(:,2)/inch2m);
plot(dat1.simout(:,1), dat3.simout(:,2)/inch2m);
plot(dat1.simout(:,1), dat4.simout(:,2)/inch2m);
xlabel('Crank angle (rad)');
ylabel('Piston height (inch)');

%% Part b plot

clf;
plot(dat1.simout(:,1), dat1.simout(:,3)/inch2m);
hold on;
plot(dat1.simout(:,1), dat2.simout(:,3)/inch2m);
plot(dat1.simout(:,1), dat3.simout(:,3)/inch2m);
plot(dat1.simout(:,1), dat4.simout(:,3)/inch2m);
xlabel('Crank angle (rad)');
ylabel('Piston height (inch/s)');

%%

clf;
plot(35, max(dat1.simout(:,2)) - min(dat1.simout(:,2)), 'ko')
hold on;
plot(45, max(dat2.simout(:,2)) - min(dat2.simout(:,2)), 'ko')
plot(55, max(dat3.simout(:,2)) - min(dat3.simout(:,2)), 'ko')
plot(65, max(dat4.simout(:,2)) - min(dat4.simout(:,2)), 'ko')
xlabel('\theta (deg.)');
ylabel('Piston stroke (inch)');





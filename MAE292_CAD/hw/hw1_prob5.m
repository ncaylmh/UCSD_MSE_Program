clear; close all; clc;

%% problem setup
wide = 50;
long = 100;

circ_d = [1 6 11 16 21 26];
x_dist = 2;
y_dist = 1;
edge_lim = 1;

%% number of holes
for i = 1:length(circ_d)
   num(i) =  floor((50 - 2*edge_lim - circ_d(i))/(circ_d(i) + y_dist)) + 1;
end

%% real dege

x_edge = (long -sum(circ_d) - (length(circ_d)-1)*x_dist)/2;

for i = 1:length(circ_d)
    y_edge(i) = (wide - num(i)*circ_d(i) - (num(i)-1)*y_dist)/2;  
end

%% plot
t = linspace(0, 2*pi,100);
unit_circ = [cos(t);sin(t);ones(1,length(t))];

figure(1)
plot([0 long long 0 0],[0 0 wide wide 0],'k','linewidth',2)
hold on
for i = 1:length(circ_d)
    d = circ_d(i);
    S = diag([d/2,d/2,1]);
    for j = 1:num(i)
        T = [1, 0, x_edge + d/2 + (i-1)*x_dist + sum(circ_d(1:i-1)); 
             0, 1, y_edge(i) + d/2 + (j-1)*(y_dist + d); 
             0, 0, 1];
        target_circ = (T*S)*unit_circ;
        plot(target_circ(1,:),target_circ(2,:),'k','linewidth',1)
    end
end
xlim([-10 110])
ylim([-10 60])
axis equal




clear
clc

%% Interpolation of the beam equation

% nodes at 0, L/2, L

E = 200e9; % Pa
b = 0.4; % m
h = 0.2; % m
I = b*h^3/12; % m^4
l = 10; % m 
P = 44400; % N

w = @(x_start, L, w1, q1, w2, q2, x) (1 - 3*(x-x_start).^2/L^2 + 2*(x-x_start).^3/L^3)*w1 + ...
                                     ((x-x_start) - 2*(x-x_start).^2/L+(x-x_start).^3/L^2)*q1 + ...
                                     (3*(x-x_start).^2/L^2 - 2*(x-x_start).^3/L^3)*w2 + ...
                                     ((x-x_start).^3/L^2 - (x-x_start).^2/L)*q2;
  
%% From derived solutions

w1_val = 0;
q1_val = 0;
w2_val = -7*P*l^3 / (768*E*I);
q2_val = -P*l^2 / (128*E*I);
w3_val = 0;
q3_val = P*l^2 / (32*E*I);                                
                              
%%                              

l1 = linspace(0, l/2,100);
l2 = linspace(l/2, l,100);

w_out_1 = w(0, l/2, w1_val, q1_val, w2_val, q2_val, l1);
w_out_2 = w(l/2, l/2, w2_val, q2_val, w3_val, q3_val, l2);


%% Plot out the shape of the beam deflection
dat = dlmread('y_deflection_beam_problem_ansys.txt','\t', 1, 0);
clf;
plot(l1, w_out_1, 'k');
hold on;
plot(l2, w_out_2, 'k');

% plot(l/2, w2_val, 'or');

plot(dat(:,1),dat(:,5), 'r')

% title('Red:Ansys solution with 8e7 elements, Black: Matlab with 2 elements');

ylabel('Vertical defletion');
xlabel('x');

wmin = min([w_out_1(:)' w_out_2(:)']);
wmax = max([w_out_1(:)' w_out_2(:)']);

axis([0 10.2 wmin*1.2 (wmax-wmin/10)*1.2]);





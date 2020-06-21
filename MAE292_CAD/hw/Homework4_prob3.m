
clear; clc; close all;
%% setup

% Original
L1 = 3;
L2 = 7;
L3 = 9;
R = 12.5;
L5 = 10;
d = 7;

theta_var = 35:5:70;

x_guess = [pi/4, 3*pi/4, pi/2]';

dt = 0.1;
w = 1;
tt = 0:dt:2*pi;
input_angle = w*tt;

output_angle = zeros(3, 1+length(input_angle), length(theta_var)); % the first one to store initial guess
output_angle(:,1,:) = repmat(x_guess,1,length(theta_var));

piston_height = zeros(length(theta_var), length(input_angle));

%%
for i = 1:length(theta_var)
    
    theta = theta_var(i)*pi/180;
    
    for j = 1:length(input_angle)

        theta_1 = input_angle(j);

        %% Solve numerically

        [x,fval] = fsolve(@(x)prob3_constraint(x, theta_1, L1, L2, L3, L5, R, d, theta), output_angle(:,j,i));

        output_angle(:,j+1,i) = x;
        
        % calculate the piston height
        theta_2 = x(1);
        theta_3 = x(2);
        theta_5 = x(3);

        piston_height(i,j) = L1*sin(theta_1) + L2*sin(theta_2) + L5*sin(theta_5);
        
        % Only plot solutions that satisfy a certain final tolerance
        if norm(fval) < 0.000001
            %% plot


            L1_vec = [L1*cos(theta_1), L1*sin(theta_1)];
            L2_vec = L1_vec + [L2*cos(theta_2), L2*sin(theta_2)];
            L3_vec = L2_vec + [L3*cos(theta_3), L3*sin(theta_3)];
            L5_vec = L2_vec + [L5*cos(theta_5), L5*sin(theta_5)];

            clf;

            plot([0, L1_vec(1)], [0, L1_vec(2)], 'ro-', 'linewidth', 3); % link1
            hold on;
            plot([L1_vec(1), L2_vec(1)], [L1_vec(2), L2_vec(2)], 'o-', 'linewidth', 3); % link2
            plot([L2_vec(1), L3_vec(1)], [L2_vec(2), L3_vec(2)], 'o-', 'linewidth', 3); % link3
            plot([L2_vec(1), L5_vec(1)], [L2_vec(2), L5_vec(2)], 'o-', 'linewidth', 3); % link3

            plot([d, d],[-5 20],'b--','linewidth', 1)
            plot([d d-R*cos(theta)],[0 R*sin(theta)],'g--','linewidth', 0.5)
            
            axis equal;
            axis([-5 15 -5 20]);
            
            
            drawnow;
        end
        
        
        %     pause;
    end
end

%% plot theta_1 vs theta_3
figure(1)
clf
plot(input_angle, piston_height)
legend('\theta = 35','\theta = 40','\theta = 45','\theta = 50','\theta = 55', ... 
       '\theta = 60','\theta = 65','\theta = 70','\theta = 75','Location','north')

xlabel('\theta_1 (rad)')
ylabel('Piston height')

figure(2)
clf
plot(tt(2:end), (piston_height(:,2:end)-piston_height(:,1:end-1))/dt)
legend('\theta = 35','\theta = 40','\theta = 45','\theta = 50','\theta = 55', ... 
       '\theta = 60','\theta = 65','\theta = 70','\theta = 75','Location','southeast')

xlabel('Time (s)')
ylabel('Piston velocity')

figure(3)
clf 
plot(theta_var, max(piston_height,[],2) - min(piston_height,[],2));
xlabel('Adjust angle')
ylabel('Piston stroke length')



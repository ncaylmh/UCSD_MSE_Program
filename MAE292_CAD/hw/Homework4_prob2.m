%% Now lets pre-seed the solution and store the results to plot

% Original
L1 = 4;
% L2 = 1;
L3_var = 1:5;
L4 = 10;

x_guess = [pi/2, L4];

input_angle = 0:0.1:4*pi;
output_angle = zeros(5,1+length(input_angle));
output_length = zeros(5,1+length(input_angle));

output_angle(:,1) = x_guess(1)*ones(5,1);
output_length(:,1) = x_guess(2)*ones(5,1);

%%
for i = 1:5
    
    L3 = L3_var(i);
    
    for j = 1:length(input_angle)

        theta_3 = input_angle(j);

        %% Solve numerically

        [x,fval] = fsolve(@(x)prob2_constraint(x, theta_3, L1, L3, L4), [output_angle(i,j),output_length(i,j)]);

        theta_1 = x(1);
        L2 = x(2);

        output_angle(i,j+1) = theta_1;
        output_length(i,j+1) = L2;  

        % Only plot solutions that satisfy a certain final tolerance
        if norm(fval) < 0.000001
            %% plot


            L1_vec = [L1*cos(theta_1), L1*sin(theta_1)];
            L2_vec = L1_vec + [L2*cos(theta_1 - pi/2), L2*sin(theta_1 - pi/2)];
            L4_vec = [L4, 0];
            L3_vec = L4_vec + [L3*cos(theta_3), L3*sin(theta_3)];


            clf;

            plot([0, L1_vec(1)], [0, L1_vec(2)], 'o-', 'linewidth', 3); % link1
            hold on;
            plot([0, L4_vec(1)], [0, L4_vec(2)], 'o-', 'linewidth', 3); % link4
            plot([L1_vec(1), L2_vec(1)], [L1_vec(2), L2_vec(2)], 'd-', 'linewidth', 3); % link2
            plot([L4_vec(1), L3_vec(1)], [L4_vec(2), L3_vec(2)], 'o-', 'linewidth', 3); % link3



            axis equal;
            axis(1.1*[-L1, L1+L4, -max(L1,L3), max(L1,L3)]);

            drawnow;
        end


    %     pause;
    end
end

%% plot theta_1 vs theta_3
clf
plot(input_angle, output_angle(:,2:end))
legend('L_3 = 1','L_3 = 2','L_3 = 3','L_3 = 4','L_3 = 5','Location','northeast')

ylim([0,2])
yticks([0 0.5 1 1.5 2])
xlabel('\theta_3 (rad)')
ylabel('\theta_1 (rad)')


%% plot max and min value
clf
plot(L3_var,max(output_angle(:,2:end),[],2),'r-o')
hold on
plot(L3_var,min(output_angle(:,2:end),[],2),'b-o')

axis([0 6 0 2])
xticks([0 1 2 3 4 5])
yticks([0 0.5 1 1.5 2])

xlabel('L_3 Value')
ylabel('\theta_1 Max & Min')

%% prediction
theta1_max = acos((L1 - L3_var)./L4);
theta1_min = acos((L1 + L3_var)./L4);

plot(L3_var, theta1_max, '--o')
plot(L3_var, theta1_min, '--o')





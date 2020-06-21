
function out = prob2_constraint(x, theta_3, L1, L3, L4)

    % x = [theta_1, L2]
    theta_1 = x(1);
    L2 = x(2);
    
    out = [L1*cos(theta_1) + L2*cos(theta_1 - pi/2) - L3*cos(theta_3) - L4;
           L1*sin(theta_1) + L2*sin(theta_1 - pi/2) - L3*sin(theta_3)];
       
end

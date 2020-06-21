function out = prob3_constraint(x, theta_1, L1, L2, L3, L5, R, d, theta)

    % x = [theta_2, theta_3, theta_5]
    % theta 1,2,3,5 are defined as the angle ccw, from the x-axis
    theta_2 = x(1);
    theta_3 = x(2);
    theta_5 = x(3);
    
    out = [L1*cos(theta_1) + L2*cos(theta_2) + L3*cos(theta_3) - (d - R*cos(theta));
           L1*sin(theta_1) + L2*sin(theta_2) + L3*sin(theta_3) - R*sin(theta);
           L1*cos(theta_1) + L2*cos(theta_2) + L5*cos(theta_5) - d];
       
end

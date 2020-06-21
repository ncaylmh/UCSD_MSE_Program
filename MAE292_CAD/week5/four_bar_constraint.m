
function out = four_bar_constraint(x, theta_2, l1, l2, l3, l4)

    out = [l2*cos(theta_2) + l3*cos(x(1)) - l4*cos(x(2)) - l1;
           l2*sin(theta_2) + l3*sin(x(1)) - l4*sin(x(2))];

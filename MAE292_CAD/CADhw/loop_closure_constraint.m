function fx = loop_closure_constraint(theta1, theta3, l1, l3, l4)
   l2 = sqrt(l3^2+l4^2+l1^2+2*(l3*l4*cos(theta3)-l1*l4*cos(theta1))-2*l1*l3*cos(theta1-theta3));
    fx = [l1*cos(theta1) + l2*cos(theta1-pi/2) - l3*cos(theta3) - l4;
          l1*sin(theta1) + l2*sin(theta1-pi/2) - l3*sin(theta3)];
end

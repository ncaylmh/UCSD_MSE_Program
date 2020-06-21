function fx = variable_stroke_constraint(x,theta,theta1,l1,l2,l3,l5,R,d)
    fx =[l1*cos(theta1)+12*cos(x(1))-l5*cos(x(3))-d;
          l1*sin(theta1)+l2*sin(x(1))-l5*sin(x(3))+x(4);
          l1*sin(theta1)+l2*sin(x(1))-l3*sin(x(2))+R*sin(theta);
          l3*cos(x(2))-l5*cos(x(3))-R*cos(theta)];

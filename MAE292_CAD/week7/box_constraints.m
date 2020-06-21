


function [c,ceq] = box_constraints(x, V, h)

    ceq = [x(3) - h; 
           x(1)*x(2)*x(3) - V];
    c = [];
end

function [c,ceq] = spring_constraints(dx, k, F)
%
% ...
% Force balance    
% F = f1 + f2 + f3 + ...

    ceq = [dx(2)*k(2) - F; 
           dx(1)*k(1) - dx(2)*k(2)];
    c = [];
end

function [c,ceq] = manyspring_constraints(dx, k, F)
%
% f1 = k1*(dx0 - dx1);
% f2 = k2*(dx1 - dx2);
% f3 = k2*(dx2 - dx3);
% ...
% Force balance    
% F = f1 + f2 + f3 + ...
    
    ceq = [dx(end)*k(end) - F; 
           k(1:end-1).*dx(1:end-1) - k(2:end).*dx(2:end)];
    c = [];
end
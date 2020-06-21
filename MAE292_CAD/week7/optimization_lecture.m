

%% fminsearch

fun = @(x) x^2;
out = fminsearch(fun, 20)  % function and guess

fun = @(x, a) (x - a)^2;
out = fminsearch(@(x) fun(x, 10), 20)  % function and guess using variables

%% local minima

fun = @(x) (x - 1).*(x - 3).*(x + 1).*(x+2);
out = fminsearch(fun, -20)  % function and guess using variables

x = -3:0.1:3;

clf;
plot(x, fun(x));
hold on;
plot(out, fun(out), 'ro', 'markersize',10);

%% Box optimization

V = 1;
h = 1;
t = 1;

x0 = [1, 10, 0.1];

% x = [l, w, h]
objfun = @(x) x(1)*x(2) + 2*x(1)*x(3) + 2*x(2)*x(3);

% Constraints
% l > 0
% w > 0 
lb = [0, 0, 0];

% l*h*w - V = 0
% h - H = 0;

[x, fval] = fmincon(objfun, x0, [], [], [], [], lb, [], @(x) box_constraints(x, V, h))
% analytical result
t*(V/h + 4*sqrt(V*h))
fval*t

%% Spring optimization 

% k ordered from left to right
k = [100000, 1];
F = 1;

dx0 = [0, 0];

energy = @(dx, k) (1/2)*sum(k.*dx.^2);

[dx, fval] = fmincon(@(x) energy(x, k), dx0, [], [], [], ...
                    [], [], [], @(x) spring_constraints(x, k, F))


x_rest = [1, 1];                
clf;
plot([0, x_rest(1)], [0, 0], 'b-')
hold on;
plot([x_rest(1), x_rest(1) + x_rest(2)], [0, 0], 'r-')

plot([0, x_rest(1) + dx(1)], .2+[0, 0], 'b-', 'linewidth', 3)
hold on;
plot([x_rest(1) + dx(1), x_rest(1) + x_rest(2) + dx(2) + dx(1)], .2+[0, 0], ...
      'r-', 'linewidth', 3)
quiver(x_rest(1) + x_rest(2) + dx(2) + dx(1), 0.2, 1, 0, 'g', 'linewidth',3);


axis([0, x_rest(1) + x_rest(2) + dx(2) + dx(1) + F + 0.5, -.5, .5]);

%% Many springs!

numsprings = 10;
% k ordered from left to right
k = ones(numsprings,1)*10;
% k(5) = 1;

F = 1;
x_rest = ones(numsprings);
dx0 = zeros(numsprings,1);

energy = @(dx, k) (1/2)*sum(k.*dx.^2);

[dx, fval] = fmincon(@(x) energy(x, k), dx0, [], [], [], ...
                    [], [], [], @(x) manyspring_constraints(x, k, F))
             

clf;
gg = hsv(numsprings);



plot([0, x_rest(1)], [0, 0], '-', 'color', ..., 
     gg(1,:), 'linewidth', k(1))
hold on;
plot([0, x_rest(1) + dx(1)], .2+[0, 0], '-', ...
     'color', gg(1,:), 'linewidth', k(1))

for kk = 2:numsprings
    
    dxx1 = sum(dx(1:kk-1));
    dxx2 = sum(dx(1:kk));
    
    x_rest1 = sum(x_rest(1:kk-1));
    x_rest2 = sum(x_rest(1:kk));

    plot([x_rest1, x_rest2], [0, 0], '-',  ...
        'linewidth', k(kk), 'color', gg(kk,:))
    plot([x_rest1 + dxx1, x_rest2 + dxx2], .2+[0, 0],'-',  ...
         'color', gg(kk,:), 'linewidth', k(kk))

end

quiver(x_rest2 + dxx2, 0.2, 1, 0, 'k', 'linewidth',3);
axis([0, x_rest2 + dxx2 + F + 0.5, -.5, .5]);






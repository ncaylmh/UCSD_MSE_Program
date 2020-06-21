

%% Generate some data
clear;
clf;
% close all

x = linspace(10, 100, 100)';
y = x * 2 + 23 + randn(size(x))*20;

plot(x,y,'o')
axis([0, 100, -50, 300]);    

p = polyfit(x, y, 1)

ft = fit(x, y, 'poly1')
hold on;
plot(ft);

ft2 = fit(x, y,  fittype(@(a, b, x) a*x + b))

% By hand
A = [length(x), sum(x); 
     sum(x), sum(x.^2)];
b = inv(A)*[sum(y); sum(y.*x)]

% Cramers rule
a0 = (sum(y)*sum(x.^2) - sum(x)*sum(x.*y))/(length(x)*sum(x.^2) - sum(x)^2)
a1 = (sum(y.*x)*length(x) - sum(x)*sum(y))/(length(x)*sum(x.^2) - sum(x)^2)

% From the normal equations
A = [ones(size(x)) x];
b = inv(A'*A)*(A'*y)


%% 
%%
%% Higher order data
%% Generate some data
clear;
clf;
% close all

x = linspace(0, 15, 100)';
y = x.^2*2 -2*x + 23 + randn(size(x))*20;

plot(x,y,'o')
% axis([0, 100, -50, 300]);    

p = polyfit(x, y, 2)

ft = fit(x, y, 'poly2')
hold on;
plot(ft);

ft2 = fit(x, y,  fittype(@(a, b, c, x) a*x.^2 + b*x + c))

% By hand
A = [length(x), sum(x), sum(x.^2);
     sum(x), sum(x.^2), sum(x.^3);
     sum(x.^2), sum(x.^3), sum(x.^4)];
b = inv(A)*[sum(y); sum(y.*x); sum(y.*x.^2)]

% From the normal equations
A = [ones(size(x)) x x.^2];
b = inv(A'*A)*(A'*y)



%% 
%%
%% Exponential data
%% 

clear;
clc;
clf;
% close all

x = linspace(0.01, 1, 100)';
y = 18.56*exp(x * 5) + randn(size(x))*2;

% plot(x,y,'o')
% axis([0, 100, -50, 300]);    

% quadratic fit
% p = polyfit(x, y, 2)
% 
% ft = fit(x, y, 'poly2')
% hold on;
% plot(ft);
% 
% ft2 = fit(x, y,  fittype(@(a, b, c, x) a*x.^2 + b*x + c))
% 
% % By hand
% A = [length(x), sum(x); 
%      sum(x), sum(x.^2)];
% b = inv(A)*[sum(y); sum(y.*x)]
% 
% % From the normal equations
% A = [ones(size(x)) x x.^2];
% b = inv(A'*A)*(A'*y)

semilogy(x,y,'o')
p = polyfit(x, log(y), 1);
p = [p(1) exp(p(2))]

ft = fit(x, log(y), 'poly1');
[ft.p1 exp(ft.p2)]

ft2 = fit(x, y,  fittype(@(a, b, x) b*exp(x*a)))
hold on;
plot(ft2);

% By hand
A = [length(x), sum(x); 
     sum(x), sum(x.^2)];
b = inv(A)*[sum(log(y)); sum(log(y).*x)];
b = [exp(b(1)) b(2)]

% From the normal equations
A = [ones(size(x)) x];
b = inv(A'*A)*(A'*log(y));
b = [exp(b(1)) b(2)]




%% 
%%
%% Power law data
%% 

clear;
clc;
clf;
% close all

x = logspace(0.1, 2)';
y = 13.5*x.^(0.5) + randn(size(x))*2;

% plot(x,y,'o')
% axis([0, 100, -50, 300]);    

% quadratic fit
% p = polyfit(x, y, 2)
% 
% ft = fit(x, y, 'poly2')
% hold on;
% plot(ft);
% 
% ft2 = fit(x, y,  fittype(@(a, b, c, x) a*x.^2 + b*x + c))
% 
% % By hand
% A = [length(x), sum(x); 
%      sum(x), sum(x.^2)];
% b = inv(A)*[sum(y); sum(y.*x)]
% 
% % From the normal equations
% A = [ones(size(x)) x x.^2];
% b = inv(A'*A)*(A'*y)

loglog(x, y,'o')
p = polyfit(log(x), log(y), 1);
p = [p(1) exp(p(2))]

ft = fit(log(x), log(y), 'poly1');
[ft.p1 exp(ft.p2)]

ft2 = fit(x, y,  fittype(@(a, b, x) b*x.^a))
hold on;
plot(ft2);

% By hand
A = [length(log(x)), sum(log(x)); 
     sum(log(x)), sum(log(x).^2)];
b = inv(A)*[sum(log(y)); sum(log(y).*log(x))];
b = [exp(b(1)) b(2)]

% From the normal equations
A = [ones(size(log(x))) log(x)];
b = inv(A'*A)*(A'*log(y));
b = [exp(b(1)) b(2)]


%%
%%
%% Robust fitting

clf;

x = linspace(10, 100, 20)';
y = x * 2 + 23 + randn(size(x))*20;

% add an outlier
y(1) = 300;

plot(x,y,'o')
axis([0, 100, -50, 300]);    

ft = fit(x, y, 'poly1')
hold on;
plot(ft);

ft = robustfit(x, y)
hold on;
plot(x, x*ft(2) + ft(1), 'g-');




%%
%%
%% What if uncertainty in x and y?
%  PCA

clf;

x = linspace(10, 100, 100)';
y = x * 2 + 23 + randn(size(x))*40;

X = [x y]

plot(x,y,'o')
axis([0, 100, -50, 300]);    

coeff = pca(X);
hold on;

plot(x,(x-mean(x))*coeff(2,1)/coeff(1,1)+(mean(y)),'r-');















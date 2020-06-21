
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% L06 matlab notebook

% 1. Parametric representation of curves and using anonymous functions
% 2. Generation of some data and exact fitting with lagrange polynomials 
%    and splines


%% Examine offset curves parametrically

syms t r

assume([t, r], 'real');

x = t;
y = t^4;

% define helper function
speed = @(x_dummy, y_dummy) sqrt(diff(x_dummy)^2 + diff(y_dummy)^2);
normal = @(x_dummy, y_dummy) [-diff(y_dummy)/speed(x_dummy,y_dummy), diff(x_dummy)/speed(x_dummy,y_dummy)];
tangent = @(x_dummy, y_dummy) [diff(x_dummy)/speed(x_dummy,y_dummy), diff(y_dummy)/speed(x_dummy,y_dummy)];

v = speed(x,y);
n = normal(x, y);
t_ = tangent(x, y);

offset_curve = [x,y] + r*n

tangent_offset = simplify(diff(offset_curve, t))'

% solve(tangent_offset, r)


%% Plot some offset curves for the parabola

t_real = -2:0.1:2;
r_offset = .65;

clf;
plot(subs(x, t, t_real), subs(y, t, t_real));
hold on;
plot(subs(offset_curve(1), {t, r}, {t_real, r_offset}), ...
     subs(offset_curve(2), {t, r}, {t_real, r_offset}), 'r');
grid on
% daspect([1 1 1])
axis([-1, 1, 0, 2]);
axis square

%% Lets generate some data and make lagrange and spline fits

clf;
plot([],[]);
axis([-10, 10, -10, 10])
data = ginput(10);
plot(data(:,1), data(:,2), 'o');

% LLS for this data. Build design and observation matrix and solve
X = [data(:,1).^9 data(:,1).^8 data(:,1).^7 data(:,1).^6 data(:,1).^5 data(:,1).^4 data(:,1).^3 data(:,1).^2 data(:,1).^1 data(:,1).^0];        
Y = data(:,2);
beta = inv(X)*Y;

hold on;
x_real = [-10:0.01:10];
plot(x_real, ...
     beta(1)*x_real.^9 + beta(2)*x_real.^8 + beta(3)*x_real.^7 + ... 
     beta(4)*x_real.^6 + beta(5)*x_real.^5 + beta(6)*x_real.^4 + ...
     beta(7)*x_real.^3 + beta(8)*x_real.^2 + beta(9)*x_real.^1 + ...
     beta(10)*x_real.^0)

 
% Lagrange polys
syms x_l
lagrange_poly = 0;

for kk=1:size(data,1)
    tmp_numerator = 1;
    tmp_denominator = 1;
    
    for jj=1:size(data,1)
        if jj ~= kk
            tmp_numerator = tmp_numerator*(x_l - data(jj,1));
            tmp_denominator = tmp_denominator*(data(kk,1) - data(jj,1));
        end
    end
    lagrange_poly = lagrange_poly + tmp_numerator/tmp_denominator * data(kk,2);
end
simplify(lagrange_poly);
hold on;
plot(x_real, double(subs(lagrange_poly, x_l, x_real)), 'k')

%%
% Spline
% clf;
plot(data(:,1), data(:,2), 'o');
hold on;

sp = spline(data(:,1), data(:,2), x_real);
plot(x_real, sp, 'r');

pc = pchip(data(:,1), data(:,2), x_real);
plot(x_real, pc, 'g');

axis([-10, 10, -10, 10])


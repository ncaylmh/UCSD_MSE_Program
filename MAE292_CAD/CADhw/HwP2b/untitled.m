clear;
clf;

time = linspace(0,20,21);
angle = 2*pi*time/20;
height = [0, 2.4, 8.6, 16.4, 22.6, 25, 25, 24.9, 23.9, 21.8, 18.9,16.5, 15.2, 15, 15,12.9, 7.5, 2, 0.1, 0, 0];
plot(angle,height,'ro')
axis([0,2*pi,0,25 ])



data = [];
data(:,1) = angle;
data(:,2) = height;


%%Lagrange polys
hold on
syms x_l
lagrange_poly = 0;
x_real = [0:0.01:2*pi];

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
plot(x_real, double(subs(lagrange_poly, x_l, x_real)),'b')
axis([0,2*pi,0,25 ])


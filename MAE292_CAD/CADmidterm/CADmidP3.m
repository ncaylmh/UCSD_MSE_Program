%problem3
%Tansformation
clear;
clf;
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  
           
% This is an arbitrary rotation matric
R = @(ro) [cos(ro), sin(ro),0;
           -sin(ro), cos(ro),0;
           0,      0 ,1];
%%
clf;
x = [0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19];
y = [0.13 3.02 6.29 6.52 6.52 7.21 8.20... 
     11.39 12.84   14.66   15.50   15.43   15.05   13.52...   
10.71 8.96    8.50   8.27    8.20    8.42];
%%
%2
%%lagrange
clf;
syms x_l 
data(:,1)=x;
data(:,2)=y;
lagrange_poly = 0;
x_real = [0:0.01:19];
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
lagrange_y = double(subs(lagrange_poly, x_l, x_real));
hold on;
axis equal
axis([0, 20, 0, 20])
plot(data(:,1),data(:,2),"r o")
plot(x_real, lagrange_y, 'k')
xlabel('x')
ylabel('y')
title('Lagrange fits', 'Fontweight','b')

%%
%3
yline = [];
for realx = 0:0.01:19
    newy = (y(ceil(realx)+1)-y(floor(realx)+1))*(realx-floor(realx))/1+y(floor(realx)+1);
    yline = [yline, newy];
end
%overshot for langrange
overshot_ysquare = (yline-lagrange_y).^2;
overshot_sum =sum(overshot_ysquare);

%%
%4
% Spline 
clf;
plot(data(:,1),data(:,2),"r o")
hold on
sp = spline(x, y, x_real);
plot(x_real, sp, 'black');
%overshoot for spline
overshot_ysquare_spline = (yline-sp).^2;
overshot_sum_spline =sum(overshot_ysquare_spline);
title('Spline fits', 'Fontweight','b')
%%
%5
clf;    
originaldata =[x;
             y;
             ones(size(x));];
rflect_left=T(0,0.13)*R(pi)*T(0,-0.13)*originaldata;
rflect_right=T(19,8.42)*R(pi)*T(-19,-8.42)*originaldata;
newdataset=[fliplr(rflect_left), originaldata,fliplr(rflect_right)];
%plot(rflect_left(1,:),rflect_left(2,:),'-o b')
plot(newdataset(1,1:20),newdataset(2,1:20),'-o b')
hold on
%plot(originaldata(1,:),originaldata(2,:),'-o k')
plot(newdataset(1,21:40),newdataset(2,21:40),'-o k')
hold on
%plot(rflect_right(1,:),rflect_right(2,:),'-o b')
plot(newdataset(1,41:60),newdataset(2,41:60),'-o b')
hold on
plot([0,0],[-20,20],'-- k')
hold on
plot([19,19],[-20,20],'-- k')
axis([-20,40,-20,20]);
title('Extensional Data', 'Fontweight','b')
%%
%6
clf;
lagrange_poly6 = 0;
syms x_l6
x_real6 = [-19:0.01:38];
newdataset(:,21) = [];
newdataset(:,40) = [];
newdataset_T=newdataset';
for mm=1:size(newdataset_T,1) 
    tmp_numerator6 = 1;
    tmp_denominator6 = 1;
    for ll=1:size(newdataset_T,1)
        if ll ~= mm
            tmp_numerator6 = tmp_numerator6*(x_l6 - newdataset_T(ll,1));
            tmp_denominator6 = tmp_denominator6*(newdataset_T(mm,1) - newdataset_T(ll,1)); 
        end
    end
    lagrange_poly6 = lagrange_poly6 + tmp_numerator6/tmp_denominator6 * newdataset_T(mm,2); 
end
simplify(lagrange_poly6);
lagrange_y6 = double(subs(lagrange_poly6, x_l6, x_real6));
hold on;
axis equal
axis([-20, 40, -20, 20])
plot(newdataset_T(:,1),newdataset_T(:,2),"r o")
plot(x_real6, lagrange_y6, 'k')
xlabel('x')
ylabel('y')
title('New Lagrange fits', 'Fontweight','b')

%spline
clf;
plot(newdataset_T(:,1),newdataset_T(:,2),"r o")
hold on
sp6 = spline(newdataset_T(:,1), newdataset_T(:,2), x_real6);
plot(x_real6, sp6, 'black');
title('New Spline fits', 'Fontweight','b')

%overshot for lagrange
lagrange_y6_real = double(subs(lagrange_poly6, x_l6, x_real));
overshot_ysquare6 = (yline-lagrange_y6_real).^2;
overshot_sum6 =sum(overshot_ysquare6);

%overshot for  spline
sp6_real = spline(newdataset_T(:,1), newdataset_T(:,2), x_real);
overshot_ysquare_spline6 = (yline-sp6_real).^2;
overshot_sum_spline6 =sum(overshot_ysquare_spline6);

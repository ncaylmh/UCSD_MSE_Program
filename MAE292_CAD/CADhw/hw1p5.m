plot_points = @(list_of_points) plot(list_of_points(1,:), list_of_points(2,:), 'black');

% This is an arbitrary translation matrix        
T = @(tx, ty) [eye(3,2) [tx ty 1]'];

% This is an arbitrary scaling matrix
S = @(sx, sy) [sx, 0,  0; 
               0,  sy, 0;
               0,  0,  1];  

%% Metamaterials example
clf;
% make a circle
theta = linspace(0, 2*pi, 1000);
[x, y] = pol2cart(theta, ones(size(theta)));
R = 2 * ones(size(x));
circle = [x; y; R];



% squash it a bit
%squashed = S(1, 0.7)*circle;
%plot_points(squashed);
%axis equal;
%axis([-4, 4, -4, 4], 'equal');

%% Now lets make an array of these shapes with a sinusoidal gradient in size, and 
%  an linearly decreasing gradient in angle. 
clf;

v_scale = 1;              % vertical scale
h_scale = 2;            % horizontal offset
%lambda = .3;              % sinusoidal scale
Nx = 6;                 % number of points
Ny = 4;                  % number of points
sc = 0.5;
s = [1, 6, 11, 16, 21, 26];

for ii = 1:6
    sx = 1;
    sy = 1;
    sxtotal = 0;
    sd = 0;
    for iii = 1:(ii-1)
        sd = sd+s(iii);
    end    
    sxtotal =  s(ii)/2 - s(1)/2+sd;
    
    new_circle = T(((sxtotal+(ii-1)*h_scale))/2, s(ii)/4)*S(s(ii)/2, s(ii)/2)*circle;
    
    array = horzcat(array, new_circle);
    
    iiy=1;
    %%while(idivide(48, int16(iiys(ii)+1),'floor') > 0)%iiy*(v_scale+s(ii))+v_scale)>= >0 )
    while(iiy< idivide(48, int16(s(ii)+1),'floor'))
        new_circle1 = T(0, iiy*(v_scale+s(ii))/2)*new_circle;
        array = horzcat(array, new_circle1);
        iiy = iiy+1
    end
end
%*vertical_array = array;
%for ii = 1:Ny
%    vertical_array = horzcat(vertical_array, T(0, ii*v_scale+)*array);
%end

plot(array(1,:), array(2,:), '.')

rectangle('Position',[-5,-1,100,50]) 


axis([-10, 120, -10, 60], 'equal');



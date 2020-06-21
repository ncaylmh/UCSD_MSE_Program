clear; clc; close all;

%% the basic shape, located at the third quadrant

theta = linspace(pi,3*pi/2,100);

gd_spiral = [cos(theta); sin(theta); ones(1,100)];

bd_box = [0, -1, -1,  0, 0;
         0,  0, -1, -1, 0;
         1,  1,  1,  1, 1];

%% Golden spiral by Fibonacci sequence

Fib = zeros(20,1);

Fib(1) = 1;
Fib(2) = 1;

% rotation pi/2 every step 
T_rot = [cos(pi/2) -sin(pi/2) 0;
         sin(pi/2)  cos(pi/2) 0;
         0          0         1];
% target Fibonacci number
n = 16;

for i = 1:n
    if i == 1
        plot(gd_spiral(1,:),gd_spiral(2,:),'r')
        hold on
        plot(bd_box(1,:),bd_box(2,:),'b')
        
        gd_spiral_pre = gd_spiral;
        bd_box_pre = bd_box;
    else
        % generate new Fibonacci sequence
        if i >= 3
           Fib(i) = Fib(i-2) + Fib(i-1); 
        end

        % scaling
        T_sc = [Fib(i)/Fib(i-1) 0 0;
                0 Fib(i)/Fib(i-1) 0;
                0 0 1];
            
        % perform rotate and scaling
        gd_spiral_cur = T_sc*T_rot*gd_spiral_pre;
        bd_box_cur = T_sc*T_rot*bd_box_pre;
        
        % find out the translation distance
        dxdy = gd_spiral_pre(:,end) - gd_spiral_cur(:,1);
        
        T_trans = eye(3);
        T_trans(:,3) = T_trans(:,3) + dxdy;
        
        % perform translation to connect the curves 
        gd_spiral_cur = T_trans*gd_spiral_cur;
        bd_box_cur = T_trans*bd_box_cur;
        
        % plot
        plot(gd_spiral_cur(1,:),gd_spiral_cur(2,:),'r')
        plot(bd_box_cur(1,:),bd_box_cur(2,:),'b')
        
        % update the arc and box
        gd_spiral_pre = gd_spiral_cur;
        bd_box_pre = bd_box_cur;
        
    end
end

axis equal

xlabel('X')
ylabel('Y')
title(['Golden spiral up to ',num2str(n),'th Fibonacci number'])

%%
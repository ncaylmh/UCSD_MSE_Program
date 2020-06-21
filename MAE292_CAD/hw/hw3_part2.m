
%%

time = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
height = [0, 2.4, 8.6, 16.4, 22.6, 25, ...
          25, 24.9, 23.9, 21.8, 18.9, 16.5, ...
          15.2, 15, 15, 12.9, 7.5, 2, 0.1, 0, 0];

angle = time/20 * 2*pi;      

%% a

plot(angle, height);

%% b

% Lagrange polys
syms x_l
lagrange_poly = 0;

for kk=1:size(angle,2)
    tmp_numerator = 1;
    tmp_denominator = 1;
    
    for jj=1:size(angle,2)
        if jj ~= kk
            tmp_numerator = tmp_numerator*(x_l - angle(jj));
            tmp_denominator = tmp_denominator*(angle(kk) - angle(jj));
        end
    end
    lagrange_poly = lagrange_poly + tmp_numerator/tmp_denominator * height(kk);
end
simplify(lagrange_poly);

clf;
subplot(1,2,1);
plot(angle, height, 'ro');
hold on;
plot(0:0.1:2*pi, double(subs(lagrange_poly, x_l, 0:0.1:2*pi)), 'k')
axis([0, 2*pi, 0, 25]);
title('Lagrange fit');
xlabel('Angle');
ylabel('Follower height (cm)')

%% c

ang_interp = 0:0.01:2*pi;
sp = spline(angle, height, ang_interp);

subplot(1,2,2);
plot(angle, height, 'ro');
hold on;
plot(ang_interp, sp, 'k');
axis([0, 2*pi, 0, 30]);

sp = pchip(angle, height, ang_interp);

plot(angle, height, 'ro');
hold on;
plot(ang_interp, sp, 'g');
axis([0, 2*pi, 0, 30]);

title('Spline fits');
xlabel('Angle');
ylabel('Follower height (cm)')


%% d
ang_interp = 0:0.01:2*pi;

R_F = 2;
R_P = 10;

pitch_radius = R_P - R_F + pchip(angle, height, ang_interp);
[pitch_x, pitch_y] = pol2cart(ang_interp, pitch_radius);

clf;
plot(pitch_x, pitch_y, 'g--')

%%%% generate offset

pitch_dx = gradient(pitch_x)/median(diff(ang_interp));
pitch_dy = gradient(pitch_y)/median(diff(ang_interp));

speed = sqrt(pitch_dx.^2 + pitch_dy.^2);

offset_x = pitch_x - (R_F./speed) .* pitch_dy;
offset_y = pitch_y + (R_F./speed) .* pitch_dx;
hold on;
plot(offset_x, offset_y, 'k-')

axis([-35, 30, -30, 40]);
daspect([1, 1, 1]);

%% e
clf;
R = @(theta) [cos(theta) -sin(theta); sin(theta) cos(theta)];

[follower_x, follower_y] = pol2cart(ang_interp, R_F);

for kk=0:4
    pts_pitch = R(-(kk/5)*2*pi)*[pitch_x; pitch_y];
    pts_cam = R(-(kk/5)*2*pi)*[offset_x; offset_y];
    
    subplot(1,5,kk+1);
    plot(pts_pitch(1,:), pts_pitch(2,:), '--g');
    hold on;
    plot(pts_cam(1,:), pts_cam(2,:), 'k-');
    title(['Theta = ' num2str(kk*2*pi/5) ' pi']); 
    current_height = pchip(angle, height, kk*2*pi/5);
    
    plot(follower_x + current_height + R_P - R_F, follower_y , 'r-');
    axis([-50, 50, -50, 50]);
    daspect([1, 1, 1]);

end

%% Save list of points that correspond to cam surface
a = pts_cam';
a(:,3) = 0;
a = a(1:5:end,:);
writematrix(a, 'cam_points.csv')






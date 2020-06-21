clear;clc;clf;

%%a
point1 = [4, 0]';
point2 = [1, 1]';
point3 = [0, 6]';
point4 = [-1, 1]';
point5 = [-5, 0]';
point6 = [-1, -1]';
point7 = [0, -7]';
point8 = [1, -1]';
point9 = point1;

points = [point1 point2 point3 ...
          point4 point5 point6 ...
          point7 point8 point9];
      
%Plot 
plot(points(1, :), points(2, :), 'r-o')
axis([-30, 30, -30, 30], 'equal');
homopoints=points;
homopoints(3, :)=1;

%%b
hold on
theta2 = 60 * pi / 180;
R2 = [cos(theta2)  -sin(theta2) 0;
      sin(theta2) cos(theta2) 0;
      0           0          1];
pic2 = R2 * homopoints;
plot(pic2(1, :),pic2(2, :), 'b-o')

%%c
x0=3;
y0=3;
theta3 = 30 * pi / 180;
Tf = [1 0 -x0;
      0 1 -y0;
      0 0 1];
Tb = [1 0 x0;
      0 1 y0;
      0 0 1];
R3 = [cos(theta3)  sin(theta3) 0;
      -sin(theta3) cos(theta3) 0;
      0           0          1];
pic3 = Tb* R3 * Tf * homopoints;

hold on
plot(pic3(1, :),pic3(2, :), 'g-o')

%%d
S = [2 0 0;
     0 4 0;
     0 0 1];
pic4 = S * homopoints;
hold on
plot(pic4(1, :),pic4(2, :), 'y-o')

%%e
Reflect = [-1 0 0;
           0 1 0;
           0 0 1];
pic5 = Reflect * homopoints;
hold on
plot(pic5(1, :),pic5(2, :), 'c-o')

%%f
transformationMatrixb = R2
transformationMatrixc = Tb* R2 * Tf
transformationMatrixd = S
transformationMatrixe = Reflect

       
      

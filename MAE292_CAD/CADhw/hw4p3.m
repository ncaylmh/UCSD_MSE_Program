clear
clc
close all
%% 
%problem3_1
l1 = 3;
l2 = 7;
l3 = 9;
R = 12.5;
l5 = 10;
d = 7;

pistolheight = [];
inputangle = [];
for theta=[pi/4:pi/48:pi/3]
    for theta1=[0:0.1:2*pi]
        F = @(x) variable_stroke_constraint(x,theta,theta1,l1,l2,l3,l5,R,d);
        [x,fval] = fsolve(F, [0,0,0,0]);
        if x(4)<0
            x(4) = -2*(l1*sin(theta1)+l2*sin(x(1)))-x(4);
        else
            x(4) = x(4);
        end
        pistolheight = [pistolheight,x(4)];
        inputangle = [inputangle,theta1];
    end
end

plot(inputangle(1:63),pistolheight(1:63),'o- r')
hold on
plot(inputangle(64:126),pistolheight(64:126),'o- y')
hold on
plot(inputangle(127:189),pistolheight(127:189),'o- g')
hold on
plot(inputangle(190:252),pistolheight(190:252),'o- b')

legend('theta=9pi/36','theta=10pi/36','theta=11pi/48','theta=12pi/36','location','southeast')
xlabel('Input Angle')
ylabel('Piston Height')
axis([0 2*pi 10 20])

%%
%Problem3_2
v1 = gradient(pistolheight(1:63));
v2 = gradient(pistolheight(64:126));
v3 = gradient(pistolheight(127:189));
v4 = gradient(pistolheight(190:252));

plot([0:0.1:2*pi],v1,'o- r')
hold on
plot([0:0.1:2*pi],v2,'o- y')
hold on
plot([0:0.1:2*pi],v3,'o- g')
hold on
plot([0:0.1:2*pi],v4,'o- b')

legend('theta=9pi/36','theta=10pi/36','theta=11pi/48','theta=12pi/36','location','southeast')
xlabel('Time')
ylabel('Speed of Piston')
axis([0 2*pi -0.5 0.5])

%% 
%Problem3_3
close all;
clc;
maxhlist = [];
minhlist = [];
for theta=[pi/4:pi/36:pi/3]
    pistolh = [];
    for theta1=[0:0.1:2*pi]
        F = @(x) variable_stroke_constraint(x,theta,theta1,l1,l2,l3,l5,R,d);
        [x,fval] = fsolve(F, [0,0,0,0]);
        if x(4)<0
            x(4) = -2*(l1*sin(theta1)+l2*sin(x(1)))-x(4);
        else
            x(4) = x(4);
        end
        pistolh = [pistolh,x(4)];
    end
    maxhlist = [maxhlist,max(pistolh)];
    minhlist = [minhlist,min(pistolh)];
    l = maxhlist-minhlist;
end

plot([pi/4:pi/36:pi/3],l,'- r')
xlabel('Theta')
ylabel('Stroke Length')
axis([pi/4 pi/3 3.5 6.6])

close all
clc;

%% 
%Problem2d
l1 = 4;
l4 = 10;
prompt = 'Please input the theta3 ';
theta3 = input(prompt);
for l3=[1:5]
    F = @(x) loop_closure_constraint(x, theta3, l1,  l3, l4);
    [x,fval] = fsolve(F, 0);
    theta1 = x;
end
%% 
%Problem2(e)
clc; 
theta1list = [];
theta3list = [];
for l3=[1:5]
    for theta3=[0:0.1:2*pi]
        F = @(x) loop_closure_constraint(x, theta3, l1, l3, l4);
        [x,fval] = fsolve(F, 0);
        theta1list = [theta1list,x];
        theta3list = [theta3list,theta3];
    end
end
thetapair = [theta3list; theta1list];
plot(thetapair(1,1:63),thetapair(2,1:63),'o- r')
hold on
plot(thetapair(1,64:126),thetapair(2,64:126),'o- y')
hold on
plot(thetapair(1,127:189),thetapair(2,127:189),'o- g')
hold on
plot(thetapair(1,190:252),thetapair(2,190:252),'o- b')
hold on
plot(thetapair(1,253:315),thetapair(2,253:315),'o- k')
hold on
legend('L3=1','L3=2','L3=3','L3=4','L3=5')
xlabel('theta3')
ylabel('theta1')
axis([0 2*pi 0.4 2])
%% Problem2(f)
close all
clc;
maxlist = [];
minlist = [];
for i=[1:5]
    maxlist = [maxlist,max(thetapair(2,(1+(i-1)*63):(63+(i-1)*63)))];
    minlist = [minlist,min(thetapair(2,(1+(i-1)*63):(63+(i-1)*63)))];
end
plot([1:5],maxlist,'-o r')
hold on
plot([1:5],minlist,'-o b')
legend('max(theta1)','min(theta1)','location','southwest')
xlabel('L3')
ylabel('max & min value of theta1')

close all;
clear;
clc;
%人工势建立
target = [12, 12];
obs1 = [5 6];
obs2 = [7 6];
K = 15;   %引力增益系数
M1 = 10;   %斥力增益系数
M2 = 15;   %斥力增益系数
ro = 2;    %斥力影响范围
n = 1;
step = 0.1;  %步长
%车的基础信息
v = 1;               %速度标量恒定
L = 3;               %前轮半径 wheel base
headangle = pi/6;    %heading angle init
x = 0;               %x init
y = 0;               %y init
xita = 0;            %xita init
KK = 10;             %比例控制器K
points = [0,0];
zuzuku = true;
xitas = [];
xita_dess = [];
%梯度下降法
while zuzuku
    %求三个r
    r_t = sqrt( (x-target(1))^2 + (y-target(2))^2 );
    r_obs1 = sqrt((x-obs1(1))^2 + (y-obs1(2))^2 );
    r_obs2 = sqrt((x-obs2(1))^2 + (y-obs2(2))^2 );

    %引力
    F_t = [(target(1)-x), (target(2)-y)]/r_t;

    %斥力
    if r_obs1 < ro
        F_obs1 = [(x-obs1(1))/r_obs1, (y-obs1(2))/r_obs1]*M1/r_obs1;
        %F_obs1 = 0;
    else
        F_obs1 = 0;
    end
    if r_obs2 < ro
        F_obs2 = [(x-obs2(1))/r_obs2, (y-obs2(2))/r_obs2]*M2/r_obs2;
        %F_obs2 = 0;
    else
        F_obs2 = 0;
    end
    
    %合力
    F = F_t + F_obs1 + F_obs2;
    xita_des = atan2(F(1), F(2));
    
    %控制部分
    det_xita = xita_des - xita;
    headangle = KK * det_xita;
    xita_new = v*sin(headangle)/L*step + xita;
    x_new = v*cos(headangle)*sin(xita)*step + x;
    y_new = v*cos(headangle)*cos(xita)*step + y;
    
    point = [x_new, y_new];
    points = [points; point];
    xitas = [xitas, xita];
    xita_dess = [xita_dess, xita_des];
    
    x = x_new;
    y = y_new;
    xita = xita_new;
    
    if r_t < 0.1 || x > 14 || x <0 || y >14 || y<0
        zuzuku = false;
    end
end



%画图
figure(1);
plot(points(:,1), points(:,2))
hold on 
rectangle('Position',[11.8,11.8,0.4,0.4],'Curvature',[1,1],'EdgeColor','r')
rectangle('Position',[3,4,4,4],'Curvature',[1,1],'EdgeColor','g')
rectangle('Position',[5,4,4,4],'Curvature',[1,1],'EdgeColor','g')
hold on



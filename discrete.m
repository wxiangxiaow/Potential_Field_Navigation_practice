close all;
clear;
clc;
%人工势建立
[grid_x, grid_y] = meshgrid(0:0.1:14);
z = zeros(size(grid_x));
z1 = zeros(size(grid_x));
z2 = zeros(size(grid_x));
target = [12, 12];
obs1 = [5 6];
obs2 = [7 6];
K = 15;   %引力增益系数
M1 = 10;   %斥力增益系数
M2 = 15;   %斥力增益系数
ro = 2;    %斥力影响范围
n = 1;
step = 0.1;  %步长
for i = 0:step:14
    m = 0;
    for j = 0:step:14
        m = m+1;
        r = sqrt((target(1)-i)^2 + (target(2)-j)^2);
        z(n,m) = r*K;
        
        %obs1
        r_obs1 = sqrt((obs1(1)-i)^2 + (obs1(2)-j)^2);
        if r_obs1 <= ro
            z1(n,m) = M1 / r_obs1;
        else
            z1(n,m) = 0;
        end
        
        %obs2
        r_obs2 = sqrt((obs2(1)-i)^2 + (obs2(2)-j)^2);
        if r_obs2 <= ro
            z2(n,m) = M2 / r_obs2;
        else
            z2(n,m) = 0;
        end
        
    end
    n = n + 1;
end
zz = z + z1 + z2;
%mesh(grid_x,grid_y,zz);

%梯度下降法
dir = [-1 -1;-1 0; -1 1; 0 -1; 0 1; 1 -1; 1 0; 1 1];  %动作
point = [1, 1];
points = [1, 1];
gra_min = zz(1, 1);
gra_num = 0;
gradients = [gra_min];
while gra_min ~= 0
    gras = [];
    new_points_x = [];
    new_points_y = [];
    true_x = [];
    true_y = [];
    for i=1:1:8
        new_point_x = point(1)+dir(i,1); 
        new_point_y = point(2)+dir(i,2);
        if new_point_x * new_point_y <=0 || new_point_x >141 || new_point_y >141
            
        else
            new_gra = zz(new_point_x, new_point_y);
            gras = [gras, new_gra];
            new_points_x = [new_points_x, point(1)+dir(i,1)];
            new_points_y = [new_points_y, point(2)+dir(i,2)];
            true_x = [true_x, true(1)+(dir(i,1)*step)];
            true_y = [true_y, true(2)+(dir(i,2)*step)];
        end
    end
    [gra_min, gra_num] = min(gras);
    point = [new_points_x(gra_num), new_points_y(gra_num)];
    true = [true_x(gra_num), true_y(gra_num)];
    points = [points; true];
    gradients = [gradients, gra_min];
end

%画图
xp = zeros(length(points));
yp = zeros(length(points));
for i=1:1:length(points)
    xp(i) = points(i,1)-1;
    yp(i) = points(i,2)-1;
end
mesh(grid_x,grid_y,zz);
hold on;
plot3(xp, yp, gradients);
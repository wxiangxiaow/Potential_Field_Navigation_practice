# Potential_Field_Navigation_practice
A test of potential field navigation practice.

The work area is a square from (0,0) to (14,14) in the (x,y) plane.  The goal is at (12,12).  There are obstacles at (5,6) and (7,6).  Use a repulsive potential of Ki/ri for each obstacle, with ri the vector to the i-th obstacle.  For the target use an attractive potential of KT*rT , with rT the vector to the target. 

run <discrete.m>


The potntial fields in 3-D polt is 

![](https://github.com/wxiangxiaow/Potential_Field_Navigation_practice/blob/main/imgs/%E4%BA%BA%E5%B7%A5%E5%8A%BF%E5%9C%BA%E5%9B%BE.png)

Without the robot dynamics, the trajectory should be

![](https://github.com/wxiangxiaow/Potential_Field_Navigation_practice/blob/main/imgs/1.png)

With the mobile robot dynamic below starting at (1,1):

x_dot = VcosΦsinθ

y_dot = VcosΦcosθ

θ_dot = V/L*sinΦ

with (x,y) the position, θ the heading angle, V the wheel speed, L the wheel base, and Φ the steering angle. Set L= 3. run <path.m>, the trajectory should be:

![](https://github.com/wxiangxiaow/Potential_Field_Navigation_practice/blob/main/imgs/path.png)

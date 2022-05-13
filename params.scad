width = 6;
lower_length = 80;
upper_length = 70;
scale = 1/3;
axis_diam = 3;
hinge_inner = 10;
hinge_outer = 5;
slide_diam = 8;
slide_offset_vert = 10; // Vertical distans from gimbal center to the center of the guide ball
slide_offset_horiz = upper_length*scale + 4;// Horizontal distans from gimbal center to the center of the guide ball
upper_strut_dist = 16;
guide_thickness = 2;
screw_head_height = 3;
gap = 0.2;

cam_outer = 20;
cam_high_depth = 15;
cam_length = hinge_inner + hinge_outer*2 + width *2;
cam_axis_diam = 4;
cam_inset = 1;

center_dist = 45; // Distance from gimbal center to surface of center wall
axis_lock_length = 6.1;
axis_lock_outer_diam = 5.6;
//axis_lock_screw_dist = 10;
axis_lock_screw_head_diam = 4.8;
axis_lock_height = 6.8;
axis_lock_screw_depth = 30;
$fn=100;

v = [0,slide_offset_horiz, -slide_offset_vert];
vc = (slide_diam/2 + cam_high_depth) * [0, v[2], -v[1]] / norm(v) + v;
cam_center = vc;

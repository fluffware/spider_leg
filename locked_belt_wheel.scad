use <axis_lock.scad>
use <belt_wheel.scad>
axis_diam=4;
wheel_width = 5;
wheel_diam = 40;
$fn=100;
belt_wheel(wheel_width, wheel_diam, axis_diam);
translate([0,0,wheel_width]) {
  axis_lock_open();
}


axis_diam=4;
wheel_width = 5;
wheel_diam = 40;
$fn=100;

module belt_wheel(width, diam, axis) 
{
  groove_radius = width*1.1/2;
  rotate_extrude() {
    difference() {
      translate([axis/2, 0]) {
	square([diam/2+groove_radius-axis/2,width]);
      }
      translate([diam/2+groove_radius, width/2]) {
	circle(r=groove_radius);
      }
    }
  }
}

belt_wheel(wheel_width, wheel_diam, axis_diam);

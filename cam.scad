include <params.scad>
use <axis_lock.scad>

module cam() {
  difference() {
    union() {
      cylinder(r=cam_outer, h= cam_length - cam_inset * 2, center=true);
      cylinder(d=cam_axis_diam + width, h=cam_length, center=true);
    }
    import("cam_cylinder.stl");
    cylinder(d=cam_axis_diam, h=cam_length + 1, center=true);
    translate([0,0,-(cam_length-axis_lock_length)/2+2]) {
      rotate([0,0,45]) {
	axis_lock();
      }
    }
  }
}

cam();

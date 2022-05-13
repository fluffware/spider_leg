use <../gears/gears.scad>
module small_gear() {

  $fn=100;
  axis_lock_thread_diam=3.5;
  axis_lock_thread_length=3;
  axis_diam=4;
  axis_lock_outer_diam = 5.6;
  axis_lock_length = 6.1;
  axis_lock_height = 6.7;
  modul=2;
  teeth=ceil(20/modul);
  gear_width = 4;

  lock_cylinder_radius = axis_lock_height-axis_lock_outer_diam/2 + axis_lock_thread_length;
  difference() {
    union() {
      spur_gear(modul, teeth, gear_width, axis_diam);
      cylinder(r = lock_cylinder_radius, h=gear_width+ axis_lock_length);
    }
    translate([0,0,gear_width]) {
      cylinder(d=axis_lock_outer_diam, h=axis_lock_length+1);
      translate([0,-axis_lock_outer_diam/2, 0]) {
	cube([axis_lock_height - axis_lock_outer_diam/2, axis_lock_outer_diam, axis_lock_length+1]);
      }
    }
    translate([0,0, gear_width+axis_lock_length/2]) {
      rotate([0,90,0]) {
	cylinder(d=axis_lock_thread_diam, h= lock_cylinder_radius +1);
      }
    }
    translate([0,0,-1]) {
      cylinder(d=axis_diam, h=gear_width+axis_lock_length+2);
    }
  }
}

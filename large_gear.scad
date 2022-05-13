use <../gears/gears.scad>
use <axis_lock.scad>

module large_gear() {
  $fn=100;

  modul=2;
  teeth=ceil(40/modul);
  gear_width = 4;

  lock_cylinder_radius = axis_lock_height-axis_lock_outer_diam/2 + axis_lock_thread_length;
  spur_gear(modul, teeth, gear_width, axis_diam);
  translate([0,0,gear_width]) {
    axis_lock_open(); 
  } 
}

large_gear();


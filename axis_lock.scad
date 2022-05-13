axis_lock_thread_diam=3.5;
axis_lock_thread_length=4;
axis_diam=4;
axis_lock_outer_diam = 5.6;
axis_lock_length = 6.1;
axis_lock_height = 6.7;


module axis_lock_sub(extend=0)
{
  length = max(extend, axis_lock_length/2) + axis_lock_length/2;
  lock_cylinder_radius = axis_lock_height-axis_lock_outer_diam/2 + axis_lock_thread_length;
  $fn = 100;
  cylinder(d=axis_lock_outer_diam, h=length);
  translate([0,-axis_lock_outer_diam/2, 0]) {
    cube([axis_lock_height - axis_lock_outer_diam/2, axis_lock_outer_diam, length]);
  }
  
  translate([0,0, axis_lock_length/2]) {
    rotate([0,90,0]) {
      cylinder(d=axis_lock_thread_diam, h= lock_cylinder_radius +1);
    }
  }
  
}

module axis_lock_open()
{
  $fn = 100;
  difference() {
    lock_cylinder_radius = axis_lock_height-axis_lock_outer_diam/2 + axis_lock_thread_length;
    cylinder(r=lock_cylinder_radius, h=axis_lock_length);
    axis_lock_sub(axis_lock_length/2 + 2);
  }
}





include <params.scad>


module axis_lock()
{
  translate([0,(axis_lock_height - axis_lock_outer_diam)/2, 0]) {
    cube([axis_lock_outer_diam, axis_lock_height,axis_lock_length], center= true);
    rotate([-90,0,0]) {
      cylinder(d=axis_lock_screw_head_diam, h = axis_lock_screw_depth);
    }
  }

}

axis_lock();



use <leg.scad>
include <params.scad>

rotate([0,180,0]) {
  translate([0,0,-lower_length*scale-width/2]) {
    base(upper_length, lower_length, scale, guide_thickness,  width, axis_diam, hinge_outer, hinge_inner,upper_strut_dist);
  }
}


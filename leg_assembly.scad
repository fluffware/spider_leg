include <params.scad>
use <leg.scad>
use <cam.scad>

module leg_assembly() {
translate([0,-upper_length,0]) {
  lower_leg(width, lower_length, upper_strut_dist, axis_diam, hinge_inner);
}
rotate([0,0,90]) {
  upper_leg(width, upper_length, scale, axis_diam, hinge_inner, hinge_outer, gap, slide_diam, slide_offset_horiz, slide_offset_vert);
  translate([0,0,upper_strut_dist]) {
    upper_strut(width, upper_length, scale, axis_diam, hinge_inner, hinge_outer, gap);
  }
}

translate([0,upper_length * scale,0]) {
 
  guide_strut(width, lower_length, upper_strut_dist, scale, axis_diam, hinge_inner, hinge_outer, gap);
  
}

gimbal(width, axis_diam, hinge_inner, hinge_outer, gap);

base(upper_length, lower_length, scale, guide_thickness,  width, axis_diam, hinge_outer, hinge_inner,upper_strut_dist);
}

leg_assembly();

translate(cam_center) {
  rotate([0,-90,0]) {
    cam();
  }
}

use <leg.scad>
include <params.scad>

translate([0,0,width/2]) {

  translate([0,-hinge_inner - hinge_outer-2]) {
    rotate([90,0,90]) {
      lower_leg(width, lower_length, upper_strut_dist, axis_diam, hinge_inner);
    }
  }

  rotate([180,0,0]) {
    upper_leg(width, upper_length, scale, axis_diam, hinge_inner, hinge_outer, gap, slide_diam, slide_offset_horiz, slide_offset_vert);
  }

  translate([0, hinge_inner + hinge_outer * 2 + 2,0]) {
    upper_strut(width, upper_length, scale, axis_diam, hinge_inner, hinge_outer, gap);
  }

  translate([-upper_length + hinge_inner + hinge_outer, (hinge_inner + hinge_outer) * 2.5, 0]) {
    rotate([90,180,90]) {
      guide_strut(width, lower_length, upper_strut_dist, scale, axis_diam, hinge_inner, hinge_outer, gap);
    }
  }
  
}


translate([0,(hinge_inner + hinge_outer) * 2.5,width/2]) {
  rotate([90,0,0]) {
    gimbal(width, axis_diam, hinge_inner, hinge_outer, gap);
  }
}

include<params.scad>
use<leg.scad>
use<large_gear.scad>
use<small_gear.scad>
use <drive_bearing.scad>

base_front = hinge_outer+hinge_inner/2+width+width+screw_head_height;
for(a=[0,180]) {
  rotate([0,0,a]) {
    translate([0, -center_dist,0])
    base(upper_length, lower_length, scale, guide_thickness,  width, axis_diam, hinge_outer, hinge_inner,upper_strut_dist);
  }
 }

for (s=[-1,1]) {
  scale([1,s,1]) {
    translate(cam_center+[base_front+width+gap,-center_dist,0]) {
      rotate([0,90,0]) {
	large_gear();
      }
    }
  }
 }

translate([base_front,0,0]) {
  drive_bearing();
}


axis_z = cam_center[2] + sqrt(30^2 - (center_dist - cam_center[1])^2);
translate([base_front+width+gap,0,axis_z]) {
  rotate([0,90,0]) {
    small_gear();
  }
}

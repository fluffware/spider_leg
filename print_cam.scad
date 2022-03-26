include <params.scad>
use <cam.scad>

a = cam_outer*2 + cam_length; // Just something bigger than the cam

for (rot = [90, -90]) {
    rotate([0,0,rot]) {
      translate([cam_outer +1,0,0]) {
	intersection() {
	  rotate([90,rot,0]) {
	  cam();
	  }
	  
	translate([-a/2,-a/2, 0]) {
	  cube([a,a,a]);
	}
	}
      }
    }
    
 }

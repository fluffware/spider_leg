include <params.scad>

use <drive_bearing.scad>
use <../LEGO.scad/LEGO.scad>

module drive_bearing_lego() {
  difference() {
    drive_bearing();
    translate([0,0,lower_length*scale+ width/2-1]) {
      for (y_scale=[-1,1]) {
	scale([1,y_scale,-1]) {
	  place(2.5,1.5,0) {
	    block(width=1,height=1, length=2, roadway_width=1, roadway_length=2, block_bottom_type="closed");
	  }
	}
      }
    }
  }
    
  translate([0,0,lower_length*scale+ width/2-1]) {
    for (y_scale=[-1,1]) {
      scale([1,y_scale,-1]) {
	place(2.5,1.5,0) {
	  block(width=1,height=1, length=2, horizontal_holes=true, roadway_width=1, roadway_length=2, block_bottom_type="closed");
	}
      }
      scale([1,1,-1]) {
	rotate([0,0,90]) {
	  place(-1.5,0,-1/3) {
	    block(width=3,height=1/3, length=6, roadway_width=3, roadway_length=6);
	  }
	}
      }
    }
  }
}

drive_bearing_lego();




include <params.scad>

module drive_bearing()
{
  gear_width = 4;
  axis_z = cam_center[2] + sqrt(30^2 - (center_dist - cam_center[1])^2);
  rotate([90,0,90]) {
    difference() {
	linear_extrude(height=gear_width+axis_lock_length+gap*2+width*2) {
	  offset(r=width) {
	    polygon([[-width*2,lower_length * scale - width/2,],
		     [width*2,lower_length * scale - width/2,],
		     [width*2,0],
		     [0,axis_z],
		     [-width*2,0]]);
	  }

    }
	
    holes= [[-width*2,lower_length * scale - width/2],
	    [width*2,lower_length * scale - width/2],
	    [-width, 0],
	    [width, 0]
	    ];
    for (hole = holes) {
      translate([hole[0], hole[1], -1]) {
	  cylinder(d= axis_diam, h= width+2);
      }
      translate([hole[0], hole[1], width - screw_head_height]) {
	cylinder(d1= axis_diam*2, d2 = axis_diam*2+screw_head_height+1, h= screw_head_height+1);
	translate([0,0,screw_head_height]) {
	  cylinder(d= axis_diam*2+screw_head_height, h= width+axis_lock_length + gear_width+gap*3);
	}
      }
      
    }
    translate([0, axis_z,-1]) {
      cylinder(d= cam_axis_diam, h= width*2+axis_lock_length + gear_width+gap*2 +2);
    }
    translate([0, axis_z,width]) {
	cylinder(r=30, h=gear_width+axis_lock_length+gap*2);
      }
    }
  }
}

use <hinge.scad>

include <params.scad>

module lower_leg(width, length, upper_strut_dist, axis_diam, hinge_inner)
{
  difference() {
    union() {
      translate([0,0,-lower_length+width/2]) {
	intersection() {
	  translate([-width/2, -width/2, -width/2]) {
	    cube([width, width, lower_length + upper_strut_dist]);
	  }
	  cylinder(d1=width, d2= width*5, h=  lower_length + upper_strut_dist + 1);
	}
	sphere(d=width);
      }
      rotate([0,90,0]) {
	cylinder(d=width, h = hinge_inner, center = true);
      }
      translate([0,0,upper_strut_dist]) {
	rotate([0,90,0]) {
	  cylinder(d=width, h = hinge_inner, center = true);
	}
      }
    }
    // Holes
    rotate([0,90,0]) {
      cylinder(d=axis_diam, h = hinge_inner+1, center = true);
    }
    translate([0,0,upper_strut_dist]) {
      rotate([0,90,0]) {
	cylinder(d=axis_diam, h = hinge_inner+1, center = true);
      }
    }
  }
}


module upper_strut(width, length, scale, axis_diam, hinge_inner, hinge_outer, gap) {
  hinge_offset = (hinge_inner + hinge_outer)/2;
  
  translate([-length + hinge_offset,-width/2, -width/2]) {
    cube([length * (1+scale) - hinge_offset * 2, width, width]);
  }
 
   
  translate([-length,0,0]) {
    rotate([0,90,90]) {
      outer_hinge(width,axis_diam, hinge_inner, hinge_outer, gap);
    }
  }
  translate([length*scale,0,0]) {
    rotate([0,90,-90]) {
      outer_hinge(width,axis_diam, hinge_inner, hinge_outer, gap);
    }
  }
  
}

module upper_leg(width, length, scale, axis_diam, hinge_inner, hinge_outer, gap, slide_diam, slide_offset) {
  hinge_offset = (hinge_inner + hinge_outer)/2;
  difference() {
    union() {
      translate([-length + hinge_offset,-width/2, -width/2]) {
	cube([length * (1+scale) - hinge_offset, width, width]);
      }
      
      
      translate([-length,0,0]) {
	rotate([0,90,90]) {
	  outer_hinge(width,axis_diam, hinge_inner, hinge_outer, gap);
	}
      }

      // Inner hinges
      cylinder(d=width*2, h= width, center = true);

      translate([length*scale,0,0]) {
	rotate([90,0,0]) {
	  cylinder(d=width, h= hinge_inner, center = true);
	}
      }

      // Guide ball
      translate([length*scale,0,0]) {
	translate([0,0, -slide_offset+slide_diam/2]) {
	  cylinder(d=width, h = slide_offset - slide_diam /2);
	  sphere(d=slide_diam);
	}
      }
    }

    // Holes
    cylinder(d=axis_diam, h= width+1, center = true);

    translate([length*scale,0,0]) {
      rotate([90,0,0]) {
	cylinder(d=axis_diam, h= hinge_inner+1, center = true);
      }
    }
  }
}

module guide_strut(width, length, upper_strut_dist, scale, axis_diam, hinge_inner, hinge_outer, gap) {
  hinge_offset = (hinge_inner + hinge_outer)/2;
  difference() {
    union() {
      rotate([-90,0,90]) {
	outer_hinge(width,axis_diam, hinge_inner, hinge_outer, gap);
      }
      translate([0,width*0.1,hinge_offset]) {
	cylinder(d=width*0.8,h=length*scale - hinge_offset);
      }
      translate([-width/2,-width/2,hinge_offset]) {
	cube([width, width, upper_strut_dist - hinge_offset]);
      }
      translate([0,0, upper_strut_dist]) {
	rotate([90,0,90]) {
	  cylinder(d=width,h=hinge_inner, center = true);
	}
      }
      translate([0,0, length*scale]) {
	sphere(d = width);
      }
    }
    translate([0,0,upper_strut_dist]) {
      rotate([90,0,90]) {
	cylinder(d=axis_diam, h= hinge_inner+1, center = true);
      }
    }
  }
}

module gimbal(width, axis_diam, hinge_inner, hinge_outer, gap)
{
  inner_width = hinge_inner + hinge_outer*2;

  for (a = [0,180]) {
    rotate([0,a,0]) {
      translate([0,0,width + gap]) {
	difference() {
	  cube([inner_width+width, width,width], center=true);
	  cylinder(d=axis_diam, h=width+1,center = true);
	}
      }
      translate([-(inner_width+width)/2,0,0]) {
	difference() {
	  union() {
	    cube([width, width,(width+gap)*2], center=true);
	    translate([0,0,(width+gap)]) {
	      rotate([90,0,0]) {
		cylinder(d=width, h=width, center=true);
	      }
	    }
	    translate([0,0,-(width+gap)]) {
	      rotate([90,0,0]) {
		cylinder(d=width, h=width, center=true);
	      }
	    }
	  }
	  rotate([0,90,0]) {
	    cylinder(d=axis_diam, h=width + 1, center = true);
	  }
	}
      }
    }
  }
    
}

module base(upper_length, lower_length, scale, guide_thickness, width, axis_diam, hinge_outer, hinge_inner, upper_strut_dist) {
  base_outer_length = hinge_inner + hinge_outer*2+width*4;
  guide_length= hinge_inner + hinge_outer*2+width*2+1;
  guide_height = lower_length * scale - upper_strut_dist;
  translate([0,upper_length*scale, lower_length * scale + width/2]) {
    translate([-guide_length/2, -(width/2+gap)-guide_thickness, -guide_height+gap]) {
      cube([guide_length,guide_thickness,guide_height-gap]);
    }
    translate([-guide_length/2, width/2+gap, -guide_height+ gap]) {
      cube([guide_length,guide_thickness,guide_height-gap]);
  
    }
  }
  translate([-guide_length/2, -width/2, lower_length * scale - width/2]) {
    cube([guide_length,width,width]);
  }
  for (s = [1,-1]) {
    scale([s,1,1]) {
      difference() {
	translate([-base_outer_length/2,0,0]) {
	  rotate([90,0,90]) {
	    linear_extrude(height= width - gap) {
	      offset(r=width/2) {
		polygon([[0, 0],
			 [0, lower_length * scale],
			 [upper_length * scale / 2, lower_length * scale],
			 [upper_length * scale / 2, 0],
			 [upper_length * scale, - slide_offset - cam_high_depth]
			 ]
			);
	      }
	      translate([upper_length * scale, - slide_offset - cam_high_depth]) {
		circle(d=cam_axis_diam+width);
	      }
	    }
	  }
	}

	translate([-base_outer_length/2-gap, 0, 0]) {
	  rotate([0,90,0]) {
	    cylinder(d=axis_diam, h=width+2*gap);
	  }
	  translate([0,upper_length * scale, - slide_offset - cam_high_depth]) {
	    rotate([0,90,0]) {
	      cylinder(d=cam_axis_diam, h=width+2*gap);
	    }
	  }
	}
	
      }
      translate([-base_outer_length/2, -width/2, lower_length * scale+width/2 -guide_height]) {
	cube([width-gap, upper_length*scale+ width + guide_thickness + gap, guide_height]);
      }
    }
  }
  

}


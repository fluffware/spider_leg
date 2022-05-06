include <params.scad>
use <axis_lock.scad>

module angle_marker(angle)
{
  rlen = cam_outer - cam_axis_diam - width;
  rotate(angle) {
    translate([cam_outer-rlen*0.4, 0]) {
      translate([0, -0.25]) {
	square([rlen*0.4, 0.5]);
      }
      text(text=str(abs(angle)), size=rlen*0.4, halign="right", valign="center");
    }
  }
}

module cam() {
  difference() {
    union() {
      cylinder(r=cam_outer, h= cam_length - cam_inset * 2, center=true);
      cylinder(d=cam_axis_diam + width, h=cam_length, center=true);
    }
    import("cam_cylinder.stl");
    cylinder(d=cam_axis_diam, h=cam_length + 1, center=true);
    translate([0,0,-(cam_length-axis_lock_length)/2+2]) {
      rotate([0,0,45]) {
	axis_lock();
      }
    }
    translate([0,0,(cam_length-axis_lock_length)/2-2]) {
      rotate([0,0,135]) {
	axis_lock();
      }
    }
    translate([0,0,cam_length/2-cam_inset-0.5]) {
      linear_extrude(height=1) {
	for(a=[0,90,120,180,240,270]) {
	  angle_marker(a);
	}
      }
    }
    scale([1,1,-1]) {
      translate([0,0,cam_length/2-cam_inset-0.5]) {
	linear_extrude(height=1) {
	  for(a=[0,-90,-120,-180,-240,-270]) {
	    rotate(180) {
	      scale([-1,1]) {
		angle_marker(a);
	      }
	    }
	  }
	}
      }
    }
  }
}

cam();

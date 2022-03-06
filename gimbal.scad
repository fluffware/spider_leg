$fn = 100;

function flat_dist(radius, thickness) = sqrt(radius*radius - thickness*thickness/4);



module ring(outer_radius, inner_radius, thickness, axis_diam, axes) {
  difference() {
    union() {
      intersection() {
	difference() {
	  sphere(outer_radius);
	  sphere(inner_radius);
	}
	cube([outer_radius*2 + 1, outer_radius*2 + 1, thickness],center=true);
      }
      for (axis = axes) {
	outer = axis[0];
	inner = min(axis[1],  flat_dist(inner_radius, thickness));
	angle = axis[2];
    
	rotate([0,90,angle]) {
	  translate([0,0,inner]) {
	    cylinder(d=thickness, h=(outer-inner));
	  }
	}
      }
    }
    for (axis = axes) {
      outer = max(axis[0],  flat_dist(outer_radius, thickness));
      inner = min(axis[1],  flat_dist(inner_radius, thickness));
      angle = axis[2];
    
      rotate([0,90,angle]) {
	translate([0,0,inner-1]) {
	  cylinder(d=axis_diam, h=(outer-inner)+2);
	}
	translate([0,0,outer]) {
	  cylinder(d=thickness+1, h=(outer-inner));
	}
      }
    }
  }
}

thickness = 7;
axis_gap = 0.2;
ring_gap=3;
inner_axis_offset = 1;
inner_axis_dist=20;
outer_axis_dist=50;
axis_diam = 3;

inner_inner = inner_axis_dist/2 + inner_axis_offset;

outer_outer = outer_axis_dist/2 - axis_gap;

ring_width = (outer_outer - inner_inner - ring_gap)/2;


ring(inner_inner + ring_width, inner_inner, thickness, axis_diam,
     [[inner_inner + ring_width + ring_gap - inner_axis_offset,
       inner_inner + ring_width/2,0],
      [inner_inner + ring_width + ring_gap - inner_axis_offset,
       inner_inner + ring_width/2,180],
      [inner_inner + ring_width/2,
       inner_inner - inner_axis_offset+ axis_gap,90],
      [inner_inner + ring_width/2,
       inner_inner - inner_axis_offset+ axis_gap,270]]);

ring(outer_outer, outer_outer-ring_width, thickness, axis_diam,
     [[outer_outer - ring_width/2,
       outer_outer - ring_width  - inner_axis_offset+ axis_gap,
       0],
      [outer_outer - ring_width/2,
       outer_outer - ring_width  - inner_axis_offset+ axis_gap,
       180]]);

rotate([90,0,0]) {
  cylinder(d=thickness, h= inner_axis_dist, center=true);
}
cube([10,10,thickness], center=true);

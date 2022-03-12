
function side_len(hyp, other) = sqrt(hyp*hyp - other * other);
function hyp_len(side1, side2) = sqrt(side1*side1 + side2*side2);

module outer_hinge(outer_diam, axis_diam, inner_width, outer_width, gap)
{
  difference() {
    total_width = inner_width + outer_width * 2;
    union() {
      cylinder(d = outer_diam, h= total_width, center = true);
      inner_radius = hyp_len(inner_width /2 + gap, outer_diam /2);
      rotate([0,90,0]) {
	difference() {
	  cylinder(d=total_width, h=outer_diam, center = true);
	  cylinder(r=inner_radius, h=outer_diam+1, center = true);
	  translate([-total_width, 0, -outer_diam]) {
	    cube([total_width*2 , total_width , outer_diam *2]);
	  }
	}
      }
    }
    cylinder(d = axis_diam, h = total_width + 1, center = true);
    cylinder(d =outer_diam * 1.1, h = inner_width + gap * 2, center = true);
  }
}

module inner_hinge(outer_diam, axis_diam, inner_width)
{
  difference() {
    cylinder(d =outer_diam, h = inner_width, center = true);
    cylinder(d =outer_diam, h = inner_width+1, center = true);
  }
}
$fn = 100;

outer_diam = 6;
axis_diam = 3;
inner_width = 10;
outer_width = 4;
gap = 0.2;
outer_hinge(outer_diam, axis_diam, inner_width,outer_width, gap);
inner_hinge(outer_diam, axis_diam, inner_width);

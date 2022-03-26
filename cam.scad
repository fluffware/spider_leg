include <params.scad>

module cam() {
  difference() {
    cylinder(r=cam_outer, h= cam_length, center=true);
    import("cam_cylinder.stl");
    cylinder(d=cam_axis_diam, h=cam_length + 1, center=true);
  }
}

cam();

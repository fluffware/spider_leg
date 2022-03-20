$fn=100;
difference() {
  cylinder(r=25, h= 30, center=true);
  import("/tmp/foo.stl");
}
cylinder(r=15, h=25, center=true);



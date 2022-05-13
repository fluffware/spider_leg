include<params.scad>
use<drive_bearing.scad>

translate([0,0,-(lower_length * scale + width/2)]) {
  drive_bearing();
}

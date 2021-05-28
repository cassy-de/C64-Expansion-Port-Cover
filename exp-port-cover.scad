$fn = 64;

difference() {
  hull() {
    arc();    
    standoff(0,5.5);
    standoff(0,24 + 5.5);
    standoff(80,5.5);
    standoff(80,24 + 5.5);  
  }
  standoffdrill(0,5.5);
  standoffdrill(0,24 + 5.5);
  standoffdrill(80,5.5);
  standoffdrill(80,24 + 5.5);
  LetterBlock("C64", 24, 40,-2,20);
  {
    translate([5,-12,3])
    cube([70,10,30]);
    translate([4,-27,0])
    cube([72,23,35]);
  }
}


module arc() {
 difference() {
  // outer shape
  translate([40,-15,17.5])
  roundedBox([80,30,35], 5, true);

  // inner shape
  translate([40,-16.5,17.5])
  roundedBox([71,24,35], 1, true);

  // cut the rest
  translate([0,-32.5,0])
  cube([80,10,35]);
 }
}

module standoff(x=0,y=0) {
 rotate([90,0,0])   
  // outer shape
  translate([x,y,20.5])
  cylinder(r=2,h=4,center=true);
}

module standoffdrill(x=0,y=0) {
 rotate([90,0,0])   
  // inner shape
  translate([x,y,21.5])
  cylinder(r=0.6,h=3,center=true);
}


module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				 y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
					y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis]) 
					translate([x,y,0]) 
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				y = [radius-size[1]/2, -radius+size[1]/2],
				z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}

module LetterBlock(letter, size, tranx,trany,tranz) {
        translate([tranx,trany,tranz]) {
            // convexity is needed for correct preview
            // since characters can be highly concave
            rotate([270,0,0])
            //translate([-10,41,-3])
            linear_extrude(height=1.6, convexity=4)
                text(letter, 
                     size=size*22/30,
                     font="Microgramma D Extended:style=Bold",
                     //font="Arial Rounded MT",
                     //font="Book Antiqua",
                     halign="center",
                     valign="center");
        }
    }


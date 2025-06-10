// This design fails, the prongs don't hold the scredrivers stable enough, they wobble and fall too easily.

// A clip on addition for the Raaco Open ToolBox (Product Id: 137195)
// This is a screwdrver holder made to clip over the compartments to the right of the handle.

wing = 25;
open = 30;
seat = 24;
clip = 2;
dep  = 25.5;
prong = clip;
wall = 2.4;

/*

Plan for the poly, is just half to be mirrored

<prong>
|\
| |_____________________
|__________     ________0,0        | wall
  <wing>   |   /   <seat/2     |
           |  /               dep (inside the clip)
           | |   <open/2       |
           | |_                |
           \__/

           clip (thinnest part)

*/


side_shape = [
    [0, 0], 
    [(seat/2), 0],
    [(open/2), dep - 5],
    [(open/2), dep],
    [(open/2) - 3, dep],
    [(open/2) + (clip/2), dep + 3],
    [(open/2) + clip, dep],
    [(open/2) + clip, 1],
    [(open/2) + clip + wing, 0],
    [(open/2) + clip + wing, -wall -6],
    [(open/2) + clip + wing - prong, -wall -3],
    [(open/2) + clip + wing - prong, -wall],
    [0, -wall],

];

// The handle of the screwdriver rests on the wings of each sect
module sect(th) {
    linear_extrude(th){
        union() {
            polygon(side_shape);
            mirror([1,0,0]) polygon(side_shape);
        };
    };
};


// Slots for hex bits.
module hex(){
    hex_size = 6.35;
    clearance = 0.1;
    size = hex_size + clearance;
    rotate([90,0,0]) cylinder(d=size/cos(30), h=30, $fn=6);
}

module stamp(){
    translate([0,-0.8,0]) rotate([90,0,0]) linear_extrude(2) text("mun", size = 8, halign = "center", valign = "center", font = "ProggyClean Nerd Font" );
}


// Create a series of prongs, screwdrivers drop between them.
// Doing prongs instead of holes for the screwdrivers because it is easier to put in and pull out.

// These add up to 80, that should just fit in the space above the side compartment.
edge = 5; // x2 The smallest edge for resting
gap = 12; // x3 Wide gaps for the yellow wera scredrivers with nuts
inter = 17; // x3 Whatever space is left - its not quite enough to stop them from overlapping a bit.

difference() {
union() {
translate([0,0,0]) sect(edge);
translate([0,0,edge+gap]) sect(inter);
translate([0,0,edge+gap+inter+gap]) sect(inter);
translate([0,0,edge+gap+inter+gap+inter+gap]) sect(edge);
translate([-seat/2,-wall,0]) cube([seat, wall, 80]);
translate([0,0,3.4]) stamp();
};
union(){
translate([0,10,10]) hex();
translate([0,10,20]) hex();
translate([0,10,30]) hex();
translate([0,10,40]) hex();
translate([0,10,50]) hex();
translate([0,10,60]) hex();
translate([0,10,70]) hex();
}
}

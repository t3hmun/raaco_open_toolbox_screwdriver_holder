// A clip on addition for the Raaco Open ToolBox (Product Id: 137195)
// This is a screwdrver holder made to clip over the compartments to the right of the handle.

wing = 17;
open = 30;
seat = 24;
clip = 2;
dep  = 25.5;
wall = 3;

/*

Plan for the poly, is just half to be mirrored

 _______________________
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
    [(open/2) + clip, 6],
    [(open/2) + clip + wing, 0],
    [(open/2) + clip + wing, -wall],
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

// Slots for screwdrivers
module slot(w){
    // Rotate to pointy up so it doesn't need support
    union(){
    translate([0,50,0]) rotate([90,90,0]) cylinder(d=w/cos(30), h=60, $fn=6);
    translate([0,-1,0])rotate([90,0,0]) cylinder(h=5.001, r1=3, r2=9.8, center=true);
    }
}

module stamp(){
    translate([0,-1.4,0]) rotate([90,0,0]) linear_extrude(2) text("mun", size = 8, halign = "center", valign = "center", font = "ProggyClean Nerd Font" );
}



// These add up to 80, that should just fit in the space above the side compartment.
edge = 5; 
gap = 12;
ga = 10; 
g = 5; 
inter = 17; 

offset = open/2 + clip + 0.01;

difference() {
union() {
translate([0,0,0]) sect(80);
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
translate([offset+(gap/2),0,edge+(gap/2)]) slot(gap); //BIG S-1.2x7
translate([offset+(gap/2),0,edge+gap+inter+2+(gap/2)]) slot(gap); //BIG S-1x5.5
translate([offset+(gap/2),0,edge+gap+inter+inter+gap+(gap/2)]) slot(ga); //Medium S-0.8x4.5
translate([-offset-(gap/2),0,edge+(gap/2)]) slot(gap); //BIG  PH2
translate([-offset-(gap/2),0,edge+gap+inter+2+(gap/2)]) slot(ga); // Medium PH1
translate([-offset-(gap/2),0,edge+gap+inter+inter+gap+(gap/2)]) slot(g); // small S-0.6x3.5
}
}


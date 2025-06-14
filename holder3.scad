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
    [(open/2) + clip + 0, 6],
    [(open/2) + clip + 2, 20],
    [(open/2) + clip + 10, 20],
    [(open/2) + clip + wing, 0],
    [(open/2) + clip + wing, -wall],
    [0, -wall],

];

// The handle of the screwdriver rests on the wings of each sect
module sect(th) {
    difference(){
    linear_extrude(th){
        union() {
            polygon(side_shape);
            mirror([1,0,0]) polygon(side_shape);
        };
    };
    translate([-40,0,-10]) rotate([10,0,0]) cube([80, 100, 10]);
    translate([-40,0,th]) rotate([-10,0,0]) cube([80, 100, 10]);
    }
};


// Slots for hex bits.
module hex(){
    hex_size = 6.35;
    clearance = 0.1;
    size = hex_size + clearance;
    rotate([90,0,0]) cylinder(d=size/cos(30), h=30, $fn=6);
}

// Slots for screwdrivers
module slot(uw,lw,uh){
    // Rotate to pointy up so it doesn't need support
    union(){
    translate([0,-wall+uh,0]) rotate([90,90,0]) cylinder(d=uw/cos(30), h=uh, $fn=6);
    translate([0,60,]) rotate([90,90,0]) cylinder(d=lw/cos(30), h=60, $fn=6);
    translate([0,-wall+uh+10,0])rotate([90,90,0]) cylinder(h=10, r1=lw/2/cos(30), r2=uw/2/cos(30), $fn=6);
    translate([0,-1,0])rotate([90,0,0]) cylinder(h=5.001, r1=3, r2=9.8, $fn=6, center=true);
    }
}

module stamp(){
    translate([0,-1.4,1]) rotate([90,0,0]) linear_extrude(2) text("mun", size = 9, halign = "center", valign = "center", font = "ProggyClean Nerd Font" );
}



// These add up to 80, that should just fit in the space above the side compartment.
edge = 5; 
gap = 12;
ga = 10; 
g = 5; 
inter = 17; 




offset = open/2 + clip + 0.01;

fg = 10;
space = 34;

difference() {
union() {
//translate([offset+(gap/2),0,0]) slot(12, 8,3); //BIG S-1.2x7
translate([0,0,0]) sect(88);
translate([0,0,3.4]) stamp();
};
union(){
translate([0,10,14]) hex();
translate([0,10,24]) hex();
translate([0,10,34]) hex();
translate([0,10,44]) hex();
translate([0,10,54]) hex();
translate([0,10,64]) hex();
translate([0,10,74]) hex();



translate([offset+(gap/2),0,fg]) slot(12, 8, 10); //BIG S-1.2x7
translate([offset+(gap/2),0,fg+space]) slot(12, 8, 10); //BIG S-1x5.5
translate([offset+(gap/2),0,fg+space+space]) slot(10, 6, 10); //Medium S-0.8x4.5

translate([-offset-(gap/2),0,fg]) slot(12, 8, 10); //BIG  PH2
translate([-offset-(gap/2),0,fg+space]) slot(10, 6, 10); // Medium PH1
translate([-offset-(gap/2),0,fg+space+space]) slot(5, 5, 10); // small S-0.6x3.5
}
}


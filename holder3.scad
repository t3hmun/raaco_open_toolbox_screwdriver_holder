// A clip on addition for the Raaco Open ToolBox (Product Id: 137195)
// This is a screwdrver holder made to clip over the compartments to the right of the handle.

/*
seat base and dep make up the dimensions of the what the clip fits onto.

Top left origin coordinates.
y↓
x→                               
                          ⇤ wing ⇥ 
 ____________________________________☜sbx,sby
 ___________________                 ---___  
☝    ←seat/2→    \                     /
0,0                  \                   / 
                      \   |\            /
                ↑     \  | \___       /
     ←base/2→ dep     | |     ---___/
                ⤓    __| |
                      \___/
*/

open = 30; // The max width of the clip area
seat = 24; // The width of the top of the clip area that sits on the handle
clip = 2; // Thickness of the clip vertical
dep = 25.5; // The depth indside the clip
wall = 3; // Thickness of the top surface
wing = 14; // The area for the main screwdriver holder that extennds beyong the whole clip area

sbx = (open / 2) + clip + wing; // top left of extra side block
sby = -wall; // top left of extra side block
sba = 15; // Angle of the extra side block
sbd = 20; // The depth of the extra side block
sbt = 27; // The top surface of the extra side block

side_shape = [
  [0, 0],
  [(seat / 2), 0],
  [(open / 2), dep - 5],
  [(open / 2), dep],
  [(open / 2) - 3, dep], // The point of the clip that goes under the edge
  [(open / 2) + (clip / 2), dep + 3], // The lowest point of the clip
  [(open / 2) + clip, dep],
  [(open / 2) + clip, 6], // The back of the clip - the length that flexes when being clipped on
  [(open / 2) + clip, 10], // The back of the clip - the length that flexes when being clipped on
  [(open / 2) + clip + 1, 20],
  // The extra side holes part starting from the inside bottom
  [sbx - sbd * tan(sba), sby + sbd],
  [sbx + sbt * cos(sba) - (sbd * tan(sba)) - 6, sby + sbt * sin(sba) + sbd],
  [sbx + sbt * cos(sba) - 5, sby + sbt * sin(sba) + 2],
  [sbx + sbt * cos(sba), sby + sbt * sin(sba) + 2],
  [sbx + sbt * cos(sba), sby + sbt * sin(sba)],
  [sbx, sby],
  [0, -wall], // This is back in the middle
];

// This forms the main block of the holder.
module sect(th) {
  difference() {
    linear_extrude(th) {
      union() {
        polygon(side_shape);
        mirror([1, 0, 0]) polygon(side_shape);
      }
    }
    // The sides of the compartment slope in a bit, so shave a bit off at an angle.
    translate([-70, 0, -10]) rotate([10, 0, 0]) cube([140, 35, 10]);
    translate([-70, 0, th]) rotate([-10, 0, 0]) cube([140, 35, 10]);
  }
}
;

// Slots for hex bits.
module hex() {
  hex_size = 6.35;
  clearance = 0.1;
  size = hex_size + clearance;
  rotate([90, 0, 0]) cylinder(d=size / cos(30), h=30, $fn=6);
}

// Slots for screwdrivers
module slot(gw, lw) {
  h = 4.001;
  union() {
    translate([0, 30]) rotate([90, 90, 0]) cylinder(d=lw / cos(30), h=40, $fn=6);
    translate([0, h - wall, 0]) rotate([90, 0, 0]) cylinder(h=h + 0.001, r1=3, r2=gw / 2, $fn=100); // Top guide funnel
  }
}

// Slots for screwdrivers
module slot_hex(uw, lw, uh) {
  h = 4;
  union() {
    translate([0, -wall + uh, 0]) rotate([90, 90, 0]) cylinder(d=uw / cos(30), h=uh, $fn=6); // Top hex bit you get on some screwdrivers
    translate([0, 30]) rotate([90, 90, 0]) cylinder(d=lw / cos(30), h=30, $fn=6); // The bit for the main shank of the screwdriver
    translate([0, -wall + uh + 10, 0]) rotate([90, 90, 0]) cylinder(h=10, r1=lw / 2 / cos(30), r2=uw / 2 / cos(30), $fn=6); // Funnel transitioning between the previous two
    translate([0, h - wall, 0]) rotate([90, 0, 0]) cylinder(h=h + 0.001, r1=3, r2=7.1, $fn=100); // Top guide funnel
  }
}

module stamp() {
  translate([0, -1.4, 1]) rotate([90, 0, 0]) linear_extrude(2) text("mun", size=9, halign="center", valign="center", font="ProggyClean Nerd Font");
}

offset = open / 2 + clip + (5) + 0.01;

sbo = (open / 2) + clip + wing; // The offset for the extra side block

fg = 10; // Gap from edge to middle of slot - this is fudge to maked enough space for the biggest screwdrives fit side by side.
space = 34; // gap between each large screwdriver - perfect for wera large side by side.
total_len = 88; // Total len of the whole holder - sized to fit onto the Raaco Open ToolBox

small_d = 10; // The diameter of the small slots
small_edge_dist = (small_d / 2) + 1; // The distance from the edge to the first small slot
smalls = 7; // The number of small slots
gaps = (total_len - (small_edge_dist*2)) / (smalls-1);

difference() {
  union() {
    translate([0, 0, 0]) sect(total_len);
    translate([0, 0, 3.4]) stamp();
  }

  union() {
    translate([0, 10, 14]) hex();
    translate([0, 10, 24]) hex();
    translate([0, 10, 34]) hex();
    translate([0, 10, 44]) hex();
    translate([0, 10, 54]) hex();
    translate([0, 10, 64]) hex();
    translate([0, 10, 74]) hex();

    translate([-sbo, 0, fg]) rotate([0, 0, -sba]) translate([-sbt / 2, 0, 0]) slot_hex(10, 7, 10); //MEDIUM 
    translate([-sbo, 0, fg + space]) rotate([0, 0, -sba]) translate([-sbt / 2, 0, 0]) slot_hex(10, 7, 10); //MEDIUM 
    translate([-sbo, 0, fg + space + space]) rotate([0, 0, -sba]) translate([-sbt / 2, 0, 0]) slot_hex(10, 7, 10); //MEDIUM 

    translate([sbo, 0, fg]) rotate([0, 0, sba]) translate([15, 0, 0]) slot_hex(12, 9, 10); //BIG 
    translate([sbo, 0, fg + space]) rotate([0, 0, sba]) translate([15, 0, 0]) slot_hex(12, 9, 10); //BIG 
    translate([sbo, 0, fg + space + space]) rotate([0, 0, sba]) translate([15, 0, 0]) slot_hex(12, 9, 10); //BIG 

    for (i = [0:smalls - 1]) {
      translate([offset, 0, small_edge_dist + (gaps * i)]) slot(small_d, 7);
    }

    for (i = [0:smalls - 1]) {
      translate([-offset, 0, small_edge_dist + (gaps * i)]) slot(small_d, 7);
    }
  }
}

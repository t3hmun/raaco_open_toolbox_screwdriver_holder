

wing = 30;
open = 30;
seat = 24;
clip = 2;
dep  = 25.5;
prong = clip;
wall = clip;

/*

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

linear_extrude(4)
union() {
    polygon(side_shape);
    mirror([1,0,0]) polygon(side_shape);
};

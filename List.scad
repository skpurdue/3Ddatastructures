cube([1,27,1]);
translate([0, (27-11), 1]) {
    cube([1, 11, 1]);
    }
translate([0, (27-11), 2]) {
    cube([1, 12, 1]);
    }
translate([-27, (27-11+12), 2]) {
    cube([28, 1, 1]);
    }
translate([-27, (27-11+12), 2]) {
    cube([1, 24, 1]);
    }
translate([-27-7, (27-11+12+23), 2]) {
    cube([7, 1, 1]);
    }
translate([-27-7, (27-11+12+23), 3]) {
    cube([3, 1, 1]);
    }
translate([-27-7+3, (27-11+12+23), 3]) {
    cube([12, 1, 1]);
    }
translate([-27-7+3+12, (27-11+12+23-10), 3]) {
    cube([1, 11, 1]);
    }
translate([-27-7+3+12, (27-11+12+23-10), 4]) {
    cube([1, 25, 1]);
    }
translate([-27-7+3+12, (27-11+12+23-10+25-27), 5]) {
    cube([1, 27, 1]);
    }
translate([-27-7+3+12-15, (27-11+12+23-10+25-27), 5]) {
    cube([15, 1, 1]);
    }
translate([-27-7+3+12-15, (27-11+12+23-10+25-27), 6]) {
    cube([5, 1, 1]);
    }
translate([-27-7+3+12-15+4, (27-11+12+23-10+25-27+1), 6]) {
    cube([1, 1, 1]);
    }
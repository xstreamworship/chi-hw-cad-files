difference()
{
union()
{
    // deck 
    translate([0,0,63])
      cube([92,150,2]);
    // sides
    translate([0,0,33])
      cube([92,2,30]);
    translate([0,0,43])
      cube([2,150,20]);
    translate([90,0,38])
      cube([2,150,25]);
    translate([0,148,43])
      cube([92,2,20]);
    // supports
    translate([0,0,0])
      cube([10,2,63]);
    translate([0,0,0])
      cube([2,10,63]);
    translate([0,0,0])
      cube([10,10,2]);
    
    translate([82,0,0])
      cube([10,2,63]);
    translate([90,0,0])
      cube([2,10,63]);
    translate([82,0,0])
      cube([10,10,2]);
    
    translate([82,148,0])
      cube([10,2,63]);
    translate([90,140,0])
      cube([2,10,63]);
    translate([82,140,0])
      cube([10,10,2]);
    
    translate([23,148,0])
      cube([10,2,63]);
    translate([23,140,0])
      cube([2,10,63]);
    translate([23,140,0])
      cube([10,10,2]);

    translate([3,148,12])
      cube([20,2,51]);
    translate([3,146,12])
      cube([2,4,51]);
    translate([3,146,12])
      cube([20,4,2]);
}      
union()
{
    translate([46,60,62])
      cylinder(r=39/2, h=4);
}
}
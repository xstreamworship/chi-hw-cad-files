module corner_fill(len, thick)
{
    translate([0,-(thick / 2),-(thick / 2)]) difference()
    {
        cube([len,thick / 2, thick / 2]);
        rotate([0,90,0]) translate([0,0,-1]) cylinder(h=len + 2, d=thick);
    }
}

module corner_cut(len, thick)
{
    union()
    {
        corner_fill(len, thick);
        translate([0, -(thick / 2), 0])
            cube([len, (thick / 2) + 1, 1]);
        translate([0, 0, -(thick / 2)])
            cube([len, 1, (thick / 2) + 1]);
    }
}


module top_deck(width, thick, side, ridge_h)
{    
    difference()
    {
        union()
        {
            // Front peg
            translate([thick + 0.2,-(10 - (1.5 * thick)),thick])
                difference()
                {
                    cube([(1.5 * thick) - 0.2,
                        10 - (1.5 * thick),ridge_h]);
                    translate([0,-1,0]) rotate([-90,0,90])
                        corner_cut(10 - (1.5 * thick) + 2,
                            2 * thick);
                }

            // Top deck
            translate([0,0,0]) cube([width, side, thick]);
        
            // Side
            translate([0, 0, thick])
                cube([(2.5 * thick) - 0.2, side, ridge_h]);

            translate([(2.5 * thick) - 0.2, 0, thick]) rotate([-90,0,90])
                corner_fill(side, thick);
        }
        union()
        {
            translate([0,-1,0]) rotate([-90,0,90])
                corner_cut(side + 2, 2 * thick);
        }
    }
    translate([(2.5 * thick) - 0.2, 122, thick])
        cube([width - (2.5 * thick) + 0.2, thick, ridge_h / 2]);
}



union()
{
    width=46;
    thick=2;
    side=140;
    ridge_h = 20;

    difference()
    {
        union()
        {
            // left side
            translate([0,0,0])
                top_deck(width, thick, side, ridge_h);
    
            // right side
            translate([92,0,0]) mirror() 
                top_deck(width, thick, side, ridge_h);
        }
        union()
        {
            // switch hole
            translate([width - 10,20,-1])
                cube([20,9.7,thick + 2]);
            
            // joystick hole
            translate([width, 80, -1])
                cylinder(r=20, h=thick+2);
            
            translate([width, 80,-1]) union()
            {
                rotate([0,0,45])
                    translate([23,0,0])
                    cylinder(r=1.2, h=thick+2);
                rotate([0,0,135])
                    translate([23,0,0])
                    cylinder(r=1.2, h=thick+2);
                rotate([0,0,-45])
                    translate([23,0,0])
                    cylinder(r=1.2, h=thick+2);
                rotate([0,0,-135])
                    translate([23,0,0])
                    cylinder(r=1.2, h=thick+2);
            }
            
        }
    }
}

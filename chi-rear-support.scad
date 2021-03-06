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

module leg(len, side, thick, hole)
{
    difference()
    {
        union()
        {
            // Angled side
            translate([0,0,0]) cube([side, len, thick]);
            translate([0,0,0]) cube([thick, len, side]);
            // Toe piece
            translate([0,len - thick, 0])
                difference()
            {
                union()
                {
                    cube([side, thick, side + (thick / 2)]);
                    translate([side / 2, thick, side + (thick / 2)])
                        rotate([90,0,0])
                        cylinder(h=thick, d=side);
                }
                translate([side / 2, thick + 1, side + 1])
                    rotate([90,0,0])
                    cylinder(h=thick + 2, d=hole);
            }
            // Inside corner fills
            translate([thick, 0, thick]) rotate([-90,0,90])
                corner_fill(len, thick);
            translate([0,len - thick, thick]) rotate([-90,0,0])
                corner_fill(side, thick);
            translate([thick, len - thick, side])
                rotate([0,90,90])
                corner_fill(side, thick);
        }
    }
}

module leg_with_front(width, thick, leg_len, side, leg_hole)
{
    face_h = 20;
    ridge_h = 20;
    
    // Leg
    translate([20,thick,0])
        leg(leg_len - thick, side, thick, leg_hole);
        
    // face and top plate
    difference()
    {
        translate([2.5 * thick,thick,0])
            cube([width, face_h, thick]);
        translate([2.5 * thick,thick,-1]) rotate([0,-90,90])
                corner_cut(thick + 2, 2 * thick);
    }

    translate([3.5 * thick, 2 * thick, thick])
        rotate ([180,0,0])
        corner_fill(width - (3.5 * thick), thick);

    // support ridge
    difference()
    {
        translate([2.5 * thick, thick, 0])
            cube([width - (2.5 * thick), thick, side]);
        translate([2.5 * thick, thick, -1]) rotate([0,-90,90])
            corner_cut(side + 2, 2 * thick);
    }
    translate([2.5 * thick, 2*thick, 0])
        cube([thick, ridge_h - thick, side]);

    translate([3.5 * thick, 2 * thick, thick])
        rotate([0,-90,90])
        corner_fill(side - thick, thick);
}



union()
{    
    // left side
    translate([0,0,0]) leg_with_front(46, 2, 63, 10, 3);
    
    // right side
    translate([92,0,0]) mirror () leg_with_front(46, 2, 63, 10, 3);
}

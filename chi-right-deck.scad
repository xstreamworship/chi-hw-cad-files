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


module half_piece(face_h, width, thick, side)
{
        
    // face and top plate
    difference()
    {
        union()
        {
            translate([0,0,0]) cube([width, face_h, thick]);
            translate([0,0,0]) cube([width, thick, side]);
            translate([0,0,0]) cube([thick, face_h, side]);
        }
        union()
        {
            translate([0,0,-1]) rotate([0,-90,90])
                corner_cut(side + 2, 2 * thick);
            translate([0,0,0]) rotate ([180,0,0])
                corner_cut(width, 2 * thick);
            translate([0, -1, 0]) rotate([-90,0,90])
                corner_cut(face_h + 2, 2 * thick);
        }
    }

    translate([thick,thick,thick]) rotate ([180,0,0])
        corner_fill(width - thick, thick);
    translate([thick, thick, thick]) rotate([0,-90,90])
        corner_fill(side - thick, thick);
    translate([thick, thick, thick]) rotate([-90, 0,90])
        corner_fill(face_h - thick, thick);


}

module another_piece(face_h, width, thick, side)
{
    // left side
    translate([0,0,0])
        half_piece(face_h, width, thick, side);
    // right side
    translate([width * 2,0,0]) mirror ()
        half_piece(face_h, width, thick, side);
}

union()
{
    face_h = 20;
    thick = 2;
    side = 75;
    width = 11.5;
    offs = 15;
    ridge_h = 10;
    
    
    // left side
    translate([0,0,0]) rotate([90,0,0])
        another_piece(face_h, width, thick, side);
    // right side
    translate([width * 2,-side * 2,0]) rotate([90,0,180])
        another_piece(face_h, width, thick, side);
    
    difference()
    {
        translate([0, -2 * side + offs,face_h])
            cube([thick, 2 * (side - offs), ridge_h]);
        union()
        {
            translate([-1,-offs -10, face_h + 3])
                rotate([0,90,0])
                cylinder(d=3, h=thick + 2);
            translate([-1,-side, face_h + 3])
                rotate([0,90,0])
                cylinder(d=3, h=thick + 2);
            translate([-1,-2 * side + offs + 10, face_h + 3])
                rotate([0,90,0])
                cylinder(d=3, h=thick + 2);
        }
    }
}

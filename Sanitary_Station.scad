$fn=128;

//measurement as var
cottonp_compartment_height = 90;
cottonp_compartment_radius = 30;
cottons_compartment_height = 60;
cottons_compartment_radius = 25;

wall_thickness = 2;
slit_width = 20;

cottons_z_offset = (cottons_compartment_height - 
                    cottonp_compartment_height) / 2;


//base for cotton pads (round, 5,8cm dia)
module cottonp () {
    cylinder(h = cottonp_compartment_height, 
             r = cottonp_compartment_radius,
             center =true);
}

//base for cotton swaps
module cottons () {
    translate([0, cottons_compartment_radius+3, 
               cottons_z_offset])
    cylinder(h = cottons_compartment_height,
             r = cottons_compartment_radius,
             center = true);
}

//cutout for the cotton swaps
module cottons_cutout () {
   
    difference() {
        cottons();
    
        translate([0, cottons_compartment_radius+3, 
                   cottons_z_offset + wall_thickness])
        cylinder(h = cottons_compartment_height,
                 r = cottons_compartment_radius - 
                 wall_thickness, center = true);
    }
}

module front_slit () {
    translate([cottonp_compartment_radius-wall_thickness, 0, 
               -cottonp_compartment_height / 3])
    union() {
        sphere(r = slit_width / 2);
        translate([0,0, cottonp_compartment_height / 2])
        cylinder(h = cottonp_compartment_height, d = slit_width,
                 center = true);
    }
}

//cutouts for the cotton swap + pad base
module hollow_base () {
    
    difference() {
        union() {
            cottonp();
            cottons_cutout();
        }
    
        translate([0,0, wall_thickness])
        cylinder(h = cottonp_compartment_height, 
                 r = cottonp_compartment_radius - 
                 wall_thickness, center = true);
    }

}

//cutout for easy access to cotton pads
difference() {
    hollow_base();
    front_slit();
}

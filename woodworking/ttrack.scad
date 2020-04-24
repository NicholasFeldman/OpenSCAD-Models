//////////////////////////////
// File: ttrack.scad        //
// Title: T-Track           //
// Version: 1.0.1           //
// Author: Nicholas Feldman //
//////////////////////////////

// Description:
//
// T-Track for woodworking jigs and assembly tables.
// Designed based on Rockler and Powertec tracks.
// 
// I recommend printing on it's side lengthwise,
// with tree supports only touching the buildplate for accuracy and easy cleanup.
//
// Should be compatible with most T-Bolts,
// But values might need to be tweaked based on how accurate your printer is,
// as well as to account for horizontal expansion. However, I recommend tweaking
// the horizontal expansion value in your slicer instead of adjusting here.

// Version History:
//
// 1.0.0:
//   - Initial Version, create basic t-track profile
// 1.0.1:
//   - Widen countersunk screw hole

track_height = 9.525;
track_width = 19.05;
track_length = 40;

slot_width = 9.525;
slot_depth = 7.144;

// How far below the surface the "T" is
t_slot_depth = 2.381;
t_slot_width = 14.2875;
t_slot_height = 3;

// I don't know what the point of this phat bottom is but whatever
slot_bottom_width = 11.1125;
slot_bottom_height = slot_depth - t_slot_height - t_slot_depth;

screw_hole_width = 5;
screw_hole_height = track_height - slot_depth;

track_segments = 1;

module ttrack(t) {
    translate([track_length*(t-1), 0, 0])
    difference() {
        // Main Body of the track
        cube([track_length, track_width, track_height], 0);
        
        // Main slot cutout
        translate([0, (track_width/2)-(slot_width/2), track_height-slot_depth])
        cube([track_length, slot_width, slot_depth], 0);
        
        // Wider "T" cut out
        translate([0, (track_width/2)-(t_slot_width/2), track_height-t_slot_depth-t_slot_height])
        cube([track_length, t_slot_width, t_slot_height],0);
        
        // Bottom expansion cutout
        translate([0, (track_width/2)-(slot_bottom_width/2), track_height-t_slot_depth-t_slot_height - slot_bottom_height])
        cube([track_length, slot_bottom_width, slot_bottom_height], 0);
        
        // Counterunk screw hole
        translate([track_length/2, track_width/2, 0])
        cylinder(h=screw_hole_height, d1=screw_hole_width, d2=screw_hole_width*2);
        
   }
}

for (i = [1:track_segments]) {
    ttrack(i);
}

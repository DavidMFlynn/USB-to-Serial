// ****************************************************
// Case for USB to TTL Serial Packet 8 Port PCB
// by Dave Flynn
// Created: 6/6/2020
// Revision: 1.0b1 6/6/2020
// Units: mm
// ****************************************************
//  ***** History *****
// 1.0b1 6/6/2020 First Code
// ****************************************************
//  ***** for STL output
// rotate([180,0,0]) Case_Top(nCons=8);
// Case_Bottom();
// ****************************************************

include<CommonStuffSAEmm.scad>

$fn=$preview? 24:90;
Overlap=0.05;
IDXtra=0.2;

Case_r=3;
Case_t=2;

PCB_x=121.2;
PCB_y=19.6;
PCB_z=1.65;
PCB_Bot=1.60;
PCB_Top=4.00;
PCB_Hole1_x=38.5;
PCB_Hole2_x=117.25;
PCB_Hole_y=15.25;

module RoundRect(X=10,Y=10,Z=2,R=2){
	hull(){
		translate([-X/2+R,-Y/2+R,0]) cylinder(r=R,h=Z);
		translate([X/2-R,-Y/2+R,0]) cylinder(r=R,h=Z);
		translate([-X/2+R,Y/2-R,0]) cylinder(r=R,h=Z);
		translate([X/2-R,Y/2-R,0]) cylinder(r=R,h=Z);
	} // hull
} // RoundRect

module Case_Top(nCons=8){
	difference(){
		translate([0,0,-1]) RoundRect(X=PCB_x+Case_r*2,Y=PCB_y+Case_r*2,Z=1+Case_t+PCB_Top,R=Case_r);
		
		// Alignment ridge
		translate([0,0,-1-Overlap]) RoundRect(X=PCB_x+Case_r*2-2,Y=PCB_y+Case_r*2-2,Z=1+Overlap*2,R=Case_r-1);
		
		RoundRect(X=PCB_x-2,Y=PCB_y-2,Z=PCB_Top+Overlap,R=0.1);
		
		translate([-PCB_x/2-Case_r-Overlap,-PCB_y/2+3,-2]) cube([11.2+Case_r,13,11+2]);
		
		// PCB holes
		translate([-PCB_x/2+PCB_Hole1_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4HeadHole();
		translate([-PCB_x/2+PCB_Hole2_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4HeadHole();
		
		// Connectors
		translate([-PCB_x/2+34.3,-PCB_y/2+2.5,0]){
			cube([6.8,7.7,10]);
			for (j=[1:nCons])
				translate([(0.350*25.4)*j,0,0]) cube([6.8,13,10]);
		}
	} // difference
	
	// Bolt bosses
	difference(){
		union(){
			translate([-PCB_x/2+PCB_Hole1_x,-PCB_y/2+PCB_Hole_y,0]) cylinder(d=8,h=Case_t+PCB_Bot);
			translate([-PCB_x/2+PCB_Hole2_x,-PCB_y/2+PCB_Hole_y,0]) cylinder(d=8,h=Case_t+PCB_Bot);
		} // union
		
		// PCB holes
		translate([-PCB_x/2+PCB_Hole1_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4ClearHole();
		translate([-PCB_x/2+PCB_Hole2_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4ClearHole();
	} // difference
	
} // Case_Top

//translate([0,0,Case_t+PCB_Bot+PCB_z]) Case_Top();

module Case_Bottom(){
	ScrewSpace=34;
	
	difference(){
		union(){
			RoundRect(X=PCB_x+Case_r*2,Y=PCB_y+Case_r*2,Z=Case_t+PCB_Bot+PCB_z,R=Case_r);
			
			hull(){
				translate([-PCB_x/2+5,-ScrewSpace/2,0]) cylinder(d=10,h=2);
				translate([-PCB_x/2+5,ScrewSpace/2,0]) cylinder(d=10,h=2);
			} // hull
			hull(){
				translate([PCB_x/2-5,-ScrewSpace/2,0]) cylinder(d=10,h=2);
				translate([PCB_x/2-5,ScrewSpace/2,0]) cylinder(d=10,h=2);
			} // hull
		} // union
		
		
		translate([0,0,Case_t+PCB_Bot]) RoundRect(X=PCB_x+IDXtra,Y=PCB_y+IDXtra,Z=Case_t+PCB_Bot+PCB_z,R=0.01);
		translate([0,0,Case_t]) RoundRect(X=PCB_x-3,Y=PCB_y-3,Z=Case_t+PCB_Bot+PCB_z,R=1);
		
		// PCB holes
		translate([-PCB_x/2+PCB_Hole1_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4Hole();
		translate([-PCB_x/2+PCB_Hole2_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4Hole();
		
		// mounting holes
		translate([-PCB_x/2+5,-ScrewSpace/2,2]) Bolt4ClearHole();
		translate([-PCB_x/2+5,ScrewSpace/2,2]) Bolt4ClearHole();
		translate([PCB_x/2-5,-ScrewSpace/2,2]) Bolt4ClearHole();
		translate([PCB_x/2-5,ScrewSpace/2,2]) Bolt4ClearHole();
		
		// LEDs
		translate([-PCB_x/2+24,-PCB_y/2+8,1]) cube([6,6,2]);
		
		difference(){
			translate([0,0,Case_t+PCB_Bot+PCB_z-1]) RoundRect(X=PCB_x+Case_r*2+1,Y=PCB_y+Case_r*2+1,Z=2,R=Case_r);
			
			translate([0,0,Case_t+PCB_Bot+PCB_z-1-Overlap]) RoundRect(X=PCB_x+Case_r*2-2,Y=PCB_y+Case_r*2-2,Z=2+Overlap*2,R=Case_r-1);
		} // difference
		
	} // difference
	
	// Bolt bosses
	difference(){
		union(){
			translate([-PCB_x/2+PCB_Hole1_x,-PCB_y/2+PCB_Hole_y,0]) cylinder(d=8,h=Case_t+PCB_Bot);
			translate([-PCB_x/2+PCB_Hole2_x,-PCB_y/2+PCB_Hole_y,0]) cylinder(d=8,h=Case_t+PCB_Bot);
		} // union
		
		// PCB holes
		translate([-PCB_x/2+PCB_Hole1_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4Hole();
		translate([-PCB_x/2+PCB_Hole2_x,-PCB_y/2+PCB_Hole_y,Case_t+PCB_Bot+PCB_z]) Bolt4Hole();
	} // difference
	
} // Case_Bottom

//Case_Bottom();




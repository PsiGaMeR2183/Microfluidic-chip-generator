use <basicCell.scad>
use <inlet_outlet.scad>
use <reactorBody.scad>

width = 1;
height = 1;
wall = 0.8;
spacer = 1;
columns = 6;
rows = 9;
layers = 3;
inlet =  1;
outlet = 1;
inletLenght = 5;
inletR = 0.75;

dx = 2*width+wall;
dy = 2*width+2*wall;
module outlet() {rotate ([0, 0, 180]) inlet (outlet, 5, width, inletR);}
module shell() {
    
    union (){
translate ([-dx+wall, 0, -wall]) cube ([(dx*columns)+(2*wall), dy*rows+2*wall, 2*wall+height]);
    
translate ([-6, -22, -wall]) cube ([14, 22, 2*wall+height]);
translate ([-6, -22, -wall]) cube ([14, 14, 20]);

translate ([(dx*(columns-1)-(width+wall)/2), dy*rows, -wall]) cube ([dx, 12, 2*wall+height]);
translate ([(dx*(columns-1)-(width+wall)/2), dy*rows+8, -wall]) cube ([dx, 4, 20]);

};
    }

module channels() {
  union (){
chip(width, height, wall, spacer, columns, rows, layers);
translate ([width/2, 0, 0]) inlet (inlet, 5, width, inletR);
if (columns/2 != round(columns/2)){
translate ([(columns-1)*dx+width/2, dy*(rows), 0]) outlet();}
if (columns/2 == round(columns/2)){
translate ([(columns-1)*dx+width/2, -wall, 0]) inlet (outlet, 5-wall, width, inletR);}
};  
    
    }
difference(){
//shell();
channels();



}

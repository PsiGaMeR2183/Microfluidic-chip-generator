use <basicCell.scad>
use <inlet_outlet.scad>
use <reactorBody.scad>

width = 1;
height = 1;
wall = 0.5;
spacer = 0.5;
columns = 6;
rows = 10;
layers = 5;
inlet =  1;
outlet = 1;
inletLenght = 5;
inletR = 0.75;
wall_K = 8;
ventWindow = 1;
wedge =1;
dx = 2*width+wall;
dy = 2*width+2*wall;
dz = height+spacer;
module outlet() {rotate ([0, 0, 180]) inlet (outlet, 5, width, inletR);}
module shell() {
    
    union (){
        translate ([-(width+(wall*wall_K)), -(inletLenght+(wall*wall_K)), -wall*wall_K]) cube ([(dx*columns)+2*(wall*wall_K), (dy*rows)+2*inletLenght+2*(wall*wall_K), (dz*layers)+2*(wall*wall_K)]);
        translate ([-(width+(wall*wall_K)), -(inletLenght+(wall*wall_K)), -wall*wall_K]) cube ([(dx*columns)+2*(wall*wall_K), inletLenght, 15 ]);
       

};
    }

module channels() {
  union (){
chip(width, height, wall, spacer, columns, rows, layers);
translate ([width/2, 0, 0]) inlet (inlet, 5, width, inletR);
if (columns/2 != round(columns/2)){
translate ([(columns-1)*dx+width/2, dy*(rows), 0]) outlet();}
if (columns/2 == round(columns/2)){
translate ([(columns-1)*dx+width/2, -wall, 0]) inlet (outlet, 5-wall, width, inletR);
if (ventWindow == 1){    
for (i=[0:layers-1])
{
    translate ([wall, (dy*rows)+wall, (i*dz)]) cube ([0.5, 20, 0.5]);
    }    
}
if (wedge==1) {
    
    translate ([((columns-1)*dx+width/2)+1.5, -(inletLenght+(wall*wall_K)), -wall*wall_K]) rotate ([0, 65, 0]) cube ([5, (dy*rows)+2*inletLenght+2*(wall*wall_K), 5 ]);
    }

}
};  
    
    }
difference(){
shell();
channels();



}

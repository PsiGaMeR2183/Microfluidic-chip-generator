use <basicCell.scad>
use <inlet_outlet.scad>
use <reactorBody.scad>

width = 0.5;
height = 1;
wall = 0.8;
spacer = 0.5;
columns = 10;
rows = 10;
layers = 3;
inlet =  2;
outlet = 1;
inletLenght = 5;
inletR = 0.75;
wall_K = 6;
ventWindow = 0;
wedge =0;
dx = 2*width+wall;
dy = 2*width+2*wall;
dz = height+spacer;
module outlet() {rotate ([0, 0, 180]) inlet (outlet, 5, width, inletR);}
module shell() {
    
    union (){
        translate ([-(width+(wall*wall_K)), -(inletLenght*2+(wall*wall_K)), -wall*wall_K]) cube ([(dx*columns)+2*(wall*wall_K), (dy*rows)+2*inletLenght+2*(wall*wall_K), 4+(dz*layers)+2*(wall*wall_K)]);
        
       

};
    }

module channels() {
  union (){
chip(width, height, wall, spacer, columns, rows, layers);
translate ([width/2, 0, 0]) inlet (inlet, 5, 1, inletR);
if (columns/2 != round(columns/2)){
translate ([(columns-1)*dx+width/2, dy*(rows), 0]) outlet();}
if (columns/2 == round(columns/2)){
translate ([(columns-1)*dx+width/2, -wall, 0]) inlet (outlet, 5-wall, 1, inletR);
if (ventWindow == 1){    
for (i=[0:layers-1])
{
    translate ([wall, (dy*rows)+wall, (i*dz)]) cube ([0.5, 20, 0.5]);
    }    
}
if (wedge==1) {
    
    translate ([((columns-1)*dx+width/2)+1.5, -(2*inletLenght+(wall*wall_K)), -wall*wall_K]) rotate ([0, 65, 0]) cube ([5, (dy*rows)+4*inletLenght+2*(wall*wall_K), 5 ]);
    }

}
};  
    
    }

difference(){
shell();
channels();
    translate ([-(width+(wall*wall_K)), 0, dz*layers+wall*2]) cube ([(dx*columns)+2*(wall*wall_K), (dy+1)*rows+inletLenght, 15 ]);


}
//projection(cut = true) translate ([0,0,-5])channels();
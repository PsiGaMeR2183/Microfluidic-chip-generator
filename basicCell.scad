
module basicCell(width_channel, height_channel, width_wall){
    union (){
    translate ([0, 0, 0]) 
        cube ([width_channel,width_channel+width_wall,height_channel]);
    translate ([-width_channel, width_wall, 0]) 
        cube ([width_channel, 2*width_channel+width_wall, height_channel]);
    translate ([0, 2*width_wall+width_channel, 0])
           cube ([width_channel, width_channel,height_channel]);
    }
}
//basicCell(wChannel,hChannel,wWall);
module lineFrontConnectionCell(width_channel, height_channel, width_wall){
    union (){
    translate ([0, 0, 0])
        cube ([width_channel, width_channel+width_wall, height_channel]);
    translate ([width_channel, width_wall, 0])
        cube ([width_wall+2*width_channel, width_channel, height_channel]);
    translate ([width_wall+2*width_channel, 0, 0])
        cube ([width_channel, width_wall, height_channel]);
    }    
}
//lineFrontConnectionCell (wChannel,hChannel,wWall);
module lineBackConnectionCell(width_channel, height_channel, width_wall){

    translate ([0, -width_channel, 0])
        cube ([width_wall+3*width_channel, width_channel, height_channel]);
    
}
//lineBackConnectionCell (1,1,1);
w = 0.5;
ww = 0.8;
h=1;
cellVolume = (w*(w+ww)*h)+(w*(2*w+ww)*h)+(w*w*h);
echo (cellVolume/1000, "mL - 1 cell");
echo ((cellVolume/1000)*54, "mL - 5 cells");
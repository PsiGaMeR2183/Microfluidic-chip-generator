use <basicCell.scad>
c = 1;
r = 5;
l = 1;
w = 1;
h = 1;
wW = 0.8;
s = 1;


module reactorMainBody(dx, dy, dz, width, height, wall, spacer, columns, rows, layers) 
{
    translate ([0, -(width+wall)*2, 0]) cube ([width, (width+wall)*2, height]); //inlet connection
    if (layers == 1 && columns/2 == round(columns/2)) {
            translate ([dx*(columns-1), -(width+wall)*2, 0]) cube ([width, (width+wall)*2, height]); //outlet connection in case of 1 layer and even number of columns connection
    }
    if (layers == 1 && columns/2 != round(columns/2)) {
            translate ([dx*(columns-1), dy*rows, 0]) cube ([width, (width+wall)*2, height]); //outlet connection in case of 1 layer and odd number of columns
    }
    if (layers > 1 && layers/2 == round(layers/2)) //outlet connection in case of several even number of layers and several columns
        {
        union(){
        translate ([0, -(2*width+wall), dz*(layers-1)]) cube ([width, 2*width+wall, height]);
        translate ([0, -(2*width+wall), dz*(layers-1)]) cube ([dx*(columns-1), width, height]);
        translate ([dx*(columns-1), -(2*width+wall), 0]) cube ([width, width, (dz*layers)-spacer]);
        translate ([dx*(columns-1), -(2*width+2*wall), 0]) cube ([width, width, height]);
        }
    }
    if (layers > 1 && layers/2 != round(layers/2) && columns/2 == round(columns/2)) //outlet connection in case of several odd number of layers and even number of columns
    {
        union(){
        translate ([dx*(columns-1), -(width+wall), (dz*layers)-dz]) cube ([width, width+wall, height]);
        translate ([dx*(columns-1), -(width+wall), 0]) cube ([width, width, (dz*layers)-dz]);
        translate ([dx*(columns-1), -(width+wall)*2, 0]) cube ([width, (width+wall), height]); 
        }
    }
    if (layers > 1 && layers/2 != round(layers/2) && columns/2 != round(columns/2)) //outlet connection in case of several odd number of layers and odd number of columns
    {
        union(){
        translate ([dx*(columns-1), (dy*rows)-width, (dz*layers)-dz]) cube ([width+wall, width, height]);
        translate ([dx*(columns)-width, (dy*rows)-width, 0]) cube ([width, width, (dz*layers)-spacer]);    
        translate ([dx*(columns)-width, -dy+width, 0]) cube ([width, dy*(rows+1)-width, height]);  
        translate ([dx*(columns-1), -dy, 0]) cube ([dx, width, height]);  
        }
    }
    for (i=[0:columns-1]){
        for (j=[0:rows-1]){
            for (z=[0:layers-1]){
            union()         {
                translate ([i*dx, j*dy, z*dz])   basicCell (width,height,wall);
                if (columns>1) {
                    for (i=[0:(columns/2)-1])
                        translate ([dx*2*i, dy*rows,z*dz]) lineFrontConnectionCell(width, height, wall);
    }
                if (columns>2) {
                    for (i=[0:(columns/2)-1.5])
                        translate ([dx+dx*2*i, 0,z*dz]) lineBackConnectionCell(width, height, wall);
                            }
                          }
                        }
            } 
        }
    if (layers>2) {
        for (z=[1:(layers/2)-0.5])
        translate ([0, 0, (2*dz*z)-spacer]) cube ([width, width, dz]);
    }
    if (layers>1 && (columns/2==round(columns/2))){
        for (z=[1:(layers/2)])
        translate ([dx*(columns-1), 0, (2*dz*z)-dz-spacer]) cube ([width, width, dz]);
    };
    if (layers>1 && (columns/2 != round(columns/2))){
        for (z=[1:(layers/2)])
        translate ([dx*(columns-1), (dy*rows)-width, (2*dz*z)-dz-spacer]) cube ([width, width, dz]);
    };
}        
module chip(width, height, wall, spacer, columns, rows, layers){
dx = 2*width+wall;
dy = 2*width+2*wall;
dz = height+spacer;  
union (){
    reactorMainBody(dx, dy, dz, width, height, wall, spacer, columns, rows, layers);
    
    }

}

projection () chip(w, h, wW, s, c, r, l);
//translate ([0, 0, 2*h]) lineFrontConnectionCell(w, h, wW);
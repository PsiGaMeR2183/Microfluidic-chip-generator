H_inlet1 = 10;
H_inlet2 = 10;
W = 0.5;
R_inlet1 = W;
R_inlet2 = 1.05;
W_wall = 2.5;
inletNumber = 5;
channelLenght = 10;
//inletWidth = 1;

module inlet(inletNumber, channelLenght, inletWidth, R_inlet2){

module tubeConnection(){
cylinder (h = H_inlet1, r1 = R_inlet2/2, r2 = R_inlet2, center = false, $fn=50); //входное отверстие
translate ([0, 0, H_inlet1]) cylinder (h = H_inlet2, r = R_inlet2, center = false, $fn=50); //входное отверстие
};

if (inletNumber == 1) {
union (){
translate([0, -channelLenght,0]) tubeConnection();
translate ([-inletWidth/2, -channelLenght,0]) cube ([inletWidth, channelLenght, 1]);
}
}
if (inletNumber/2 == round(inletNumber/2) && inletNumber != 1) {
union (){
    translate ([-inletWidth/2, -channelLenght,0]) cube ([inletWidth, channelLenght, 1]);
    for (i=[1:(inletNumber/2)]){
        translate ([-inletWidth/2, -channelLenght*i,0]) cube ([inletWidth, channelLenght, 1]);
        translate ([-channelLenght/2, -(channelLenght*i)-(inletWidth/2),0]) cube ([channelLenght, inletWidth, 1]);
        translate ([-channelLenght/2, -(channelLenght*i),0]) tubeConnection();
        translate ([channelLenght/2, -(channelLenght*i),0]) tubeConnection();
    }
}   
}

if (inletNumber/2 != round(inletNumber/2) && inletNumber != 1) {
union (){
    translate ([-inletWidth/2, -channelLenght*((inletNumber)/2),0]) cube ([inletWidth, channelLenght, inletWidth]);
    translate ([0, -channelLenght*((inletNumber)/2),0]) tubeConnection();
    for (i=[1:(inletNumber/2)]){
        translate ([-inletWidth/2, -channelLenght*i,0]) cube ([inletWidth, channelLenght, inletWidth]);
        translate ([-channelLenght/2, -(channelLenght*i)-(inletWidth/2),0]) cube ([channelLenght, inletWidth, inletWidth]);
        translate ([-channelLenght/2, -(channelLenght*i),0]) tubeConnection();
        translate ([channelLenght/2, -(channelLenght*i),0]) tubeConnection();
    }
}   
}
}

inlet (1, 10, 1, 1.05);
width = 1;
height = 1;
lenght = 4;
angle = 5;
tubelLenght = 60;



module y_Shape(l, w, h, a, inletH, inlet){
    

module basicsegment(l,w,h)
{
translate ([0, -w/2,-h/2]) cube ([l,w,h]);
};
union(){
rotate ([0,0,a]) basicsegment(l,w,h);
rotate ([0,0,-a]) basicsegment(l,w,h);
rotate ([0,0,180]) basicsegment(l/3,w,h);
translate ([l*cos(a)-w/2,l*sin(a), 0]) basicsegment(l*2,w,h);
translate ([l*cos(-a)-w/2,l*sin(-a), 0]) basicsegment(l*2,w,h);
if (inlet==1){
    translate ([l*cos(a)-w+l*2,0, 0]) rotate ([0,0,90])basicsegment(l*sin(a),w,h);
    translate ([l*cos(a)-w+l*2,0, 0]) rotate ([0,0,-90])basicsegment(l*sin(a),w,h);
    translate ([l*cos(a)-w*(1.5)+l*2,-w/2, 0]) cube ([w,w,inletH]);
    translate ([l*cos(a)-w*(1.5)+l*2,0, inletH-w/2]) rotate ([0,90,0]) cylinder(h=50, r1=0.65, r2=0.72, center = false, $fn=20);
}
else {
    translate ([l*cos(a)-w*(1.5)+l*2,-w/2+l*sin(a), 0]) cube ([w,w,inletH]);
    translate ([l*cos(a)-w*(1.5)+l*2,l*sin(a), inletH-w/2]) rotate ([0,90,0]) cylinder(h=50, r1=0.65, r2=0.72, center = false, $fn=20);
    translate ([l*cos(-a)-w*(1.5)+l*2,-w/2+l*sin(-a), 0]) cube ([w,w,inletH]);
    translate ([l*cos(-a)-w*(1.5)+l*2,l*sin(-a), inletH-w/2]) rotate ([0,90,0]) cylinder(h=50, r1=0.65, r2=0.72, center = false, $fn=20);
    }
}
}
projection(cut = true){
difference(){
//   translate ([-70,-13, -5]) color ("blue", 0.1) cube ([96,26,11]);
union(){
translate ([-1.1, 0, 0]) color("green") y_Shape (2.5, 0.7, 0.7, 45, 2, 2);
translate ([-2.5, 0, 0]) color("red") y_Shape (8, 1.5, 1.5, 90, 4, 1);
//    translate ([-4, 0, 0]) y_Shape (10, 1, 1, 90, 2, 1);

translate ([-3,0,0]) rotate([0,0,45]) rotate (a=-90, v=[1,1,0]) color("blue",0.5) cylinder (h=tubelLenght,r=0.5, center = false, $fn=50)   ;

rotate ([0,0,180]) translate([tubelLenght+3,0,0]) y_Shape (0.1, 1, 1, 45, 2, 1);  
//rotate ([180,0,0]) translate ([-1.1, 0, 0]) color("blue") y_Shape (2.5, 0.5, 0.7, 45, 2, 1);  
    };
//translate ([-50,-13.5, 1.25]) cube ([45,27,6]);
//translate ([-48,-11, -6]) cube ([41,22,8]);
//translate ([-48,-14, -6]) rotate ([0,0,0]) cube ([100,28,40]);
}
};
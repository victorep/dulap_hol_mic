max_height = 2500;
max_width = 800;
max_length  =670;
pal_width = 18;
default_dist_between=0.5;
washing_machine_part_height=800;
bottom_part_height=100;
door_1_part_height=800;
door_2_part_height=800;
stren_size=80;
elements=[[]];
asym_dist_len = 100;
module board(height, width,name="Undefined"){
    cube([width,pal_width,height]);
    echo(str("Board: ",name,";Size:",height,"x",+width,"x",pal_width));
}  
module vboard(height, width,name="UndefV"){
    board(height, width,name);
}
module hboard(length, width,name="UndefH"){
    rotate ([90,0,0])board(length, width,name);;
}
module stren_fb(width,height=stren_size,type="fata/spate"){
    if (height != stren_size){
        vboard(height,width-pal_width*2,str("Intaritura ",type,height));}
    else{
        vboard(height,width-pal_width*2,str("Intaritura ",type," standard"));
    }
}
module stren_lat(width,height=stren_size){
     rotate([00,0,-90]) stren_fb(width-pal_width,height,type="lateral");
}
module asym_dist(height){
    
    //light switch panel
     vboard(height-1,asym_dist_len-1,"Panel distantier");
}
module door(height,width,name=""){
        difference(){
            vboard(height,width,str("Door ",name)); 
            translate([5+35/2,pal_width+1,150])rotate ([90,0,0]) cylinder(13,35/2,35/2);
            translate([5+35/2,pal_width+1,height-150])rotate ([90,0,0]) cylinder(13,35/2,35/2);
        }
}
module doors(height, width, dist_mid=default_dist_between,dist_ud=default_dist_between){
    panel_w=width/2-dist_mid;
    panel_h=height-dist_ud;
    //door left
    door(panel_h,panel_w,"dreapta");
    //door right
    translate([(width),0,height-default_dist_between]) rotate ([00,180,0])door(panel_h,panel_w,"stanga");
    
}
module washing_machine_part(height, width, length=0){
    //assymetrical distancer
    translate([width-asym_dist_len+default_dist_between,-length] ) asym_dist(height);
    
    

    //doors
    translate([0,-length] ){
        doors(height,width-asym_dist_len-default_dist_between);
    }
    
    //raft
    translate([pal_width,0,height-pal_width] ) hboard(length-pal_width,width-pal_width*2,"raft");
    
    //strengths
    //translate([pal_width,-pal_width,0] ) stren_fb(width); //back down
    //translate([pal_width,-length+pal_width,0] ) stren_fb(width);//front down
    translate([pal_width,-pal_width,height-pal_width-stren_size] ) stren_fb(width);//back up
    //translate([pal_width,-length+pal_width,height-pal_width-stren_size] ) stren_fb(width);//front up
    //translate([pal_width,-pal_width,0] )  stren_lat(width); // down left
    //translate([pal_width+width-pal_width*3,-pal_width,0] ) stren_lat(width); // down right
    translate([pal_width+width-pal_width*3,-pal_width,height-stren_size-pal_width] ) stren_lat(length); //right up
    translate([pal_width,-pal_width,height-stren_size-pal_width] ) stren_lat(length); //left up
    

}
module bottom_part(height, width, length=0){
    
    //strengths
    translate([pal_width,-pal_width,0] ) stren_fb(width,150); //back down
    translate([pal_width,-length+pal_width,0] ) stren_fb(width,150);//front down
    //translate([pal_width,-pal_width,height-pal_width-stren_size] ) stren_fb(width);//back up
    //translate([pal_width,-length+pal_width,height-pal_width-stren_size] ) stren_fb(width);//front up
    translate([pal_width,-pal_width,0] )  stren_lat(length,150); // down left
    translate([pal_width+width-pal_width*3,-pal_width,0] ) stren_lat(length,150); // down right
    //translate([pal_width+width-pal_width*3,-pal_width,height-stren_size-pal_width] ) stren_lat(width); //right up
    //translate([pal_width,-pal_width,height-stren_size-pal_width] ) stren_lat(width); //left up
    

}
module sertare_part(height, width, length=0){
    translate([0,-length,0] )board(height-default_dist_between,width);  
    translate([pal_width,0,height-pal_width] ) hboard(length-pal_width,width-pal_width*2);
     //back up strenght
    translate([pal_width,-pal_width,height-pal_width-100] ) vboard(100,width-pal_width*2,"Intaritura fata/spate");
    
  
   
    }
module door1_part(height, width, length=0){
    light_width = 100;
    //light switch panel
    translate([0,-length,0] ) board(height-default_dist_between,light_width,"panel distanta");
    
    //doors
    translate([light_width+default_dist_between,-length,0] ){
         doors(height,width-asym_dist_len-default_dist_between);
    }
    
    //raft
    translate([pal_width,0,height-pal_width] ) hboard(length-pal_width,width-pal_width*2,"raft");
    
    //strengths
    translate([pal_width,-pal_width,0] ) stren_fb(width); //back down
    //translate([pal_width,-length+pal_width,0] ) stren_fb(width);//front down
    translate([pal_width,-pal_width,height-pal_width-stren_size] ) stren_fb(width);//back up
    //translate([pal_width,-length+pal_width,height-pal_width-stren_size] ) stren_fb(width);//front up
    //translate([pal_width,-pal_width,0] )  stren_lat(width); // down left
    //translate([pal_width+width-pal_width*3,-pal_width,0] ) stren_lat(width); // down right
        translate([pal_width+width-pal_width*3,-pal_width,height-stren_size-pal_width] ) stren_lat(length); //right up
    translate([pal_width,-pal_width,height-stren_size-pal_width] ) stren_lat(length); //left up
}

module door2_part(height, width, length=0){
    //assymetrical distancer
    translate([width-asym_dist_len+default_dist_between,-length,0] ) asym_dist(height);
    
    //doors
    translate([0,-length,0] ){
        doors(height,width-asym_dist_len-default_dist_between);
    }
    
    //strengths
    translate([pal_width,-pal_width,0] ) stren_fb(width); //back down
    //translate([pal_width,-length+pal_width,0] ) stren_fb(width);//front down
    translate([pal_width,-pal_width,height-stren_size] ) stren_fb(width);//back up
    translate([pal_width,-length+pal_width,height-stren_size] ) stren_fb(width);//front up
    //translate([pal_width,-pal_width,0] )  stren_lat(width); // down left
    //translate([pal_width+width-pal_width*3,-pal_width,0] ) stren_lat(width); // down right
    translate([pal_width+width-pal_width*3,-pal_width,height-stren_size] ) stren_lat(length); //right up
    translate([pal_width,-pal_width,height-stren_size] ) stren_lat(length); //left up

    }
module laterals(height,width,length){
    length2=200;
    //Back LEFT LAT
    translate([0,pal_width,0]) rotate ([0,0,-90]) vboard(height,length2,"stalp lateral");
    //Back RIGHT LAT
    translate([width-pal_width,pal_width,0]) rotate ([0,0,-90]) vboard(height,length2,"stalp lateral");
    
    //Front LEFT LAT
    translate([0,-length+length2+pal_width,0]) rotate ([0,0,-90]) vboard(height,length2,"stalp lateral");
    //Front RIGHT LAT
    translate([width-pal_width,-length+length2+pal_width,0]) rotate ([0,0,-90]) vboard(height,length2,"stalp lateral");
    
    //BACK LEFT BACK
    translate([pal_width,0,0]) rotate ([0,0,-0]) vboard(height,length2,"stalp spate");
    //BACK RIGHT BACK
    translate([width-length2-pal_width,0,0]) rotate ([0,0,-0]) vboard(height,length2,"stalp spate");
}
module the_thing(){
    color("white") 
    translate([0,0,0] )bottom_part(bottom_part_height,max_width,max_length);
    
    color("white") 
    translate([0,0,bottom_part_height] )washing_machine_part(washing_machine_part_height,max_width,max_length);
    //translate([0,0,washing_machine_part_height] )color("white") sertare_part(sertare_part_height,max_width,max_length);
    translate([0,0,washing_machine_part_height+bottom_part_height] )color("white") door1_part(door_1_part_height,max_width,max_length);
    translate([0,0,washing_machine_part_height+bottom_part_height+door_1_part_height] )color("white") door2_part(door_2_part_height,max_width,max_length);
    
    #laterals(max_height,max_width,max_length);
}

translate([0,0,0] ) the_thing();

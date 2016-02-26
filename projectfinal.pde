
Ladder [] ladders = new Ladder[9];
Floor [] floors = new Floor [9];
Timer timer;

import ddf.minim.*;
Minim minim;
AudioSnippet buttonsound;
AudioSnippet buttonrestart;
AudioSnippet bgm;
Role rolePikachu;
PImage imgintro;
PImage img;
PImage img3;
PImage imgbg1;
PImage imgbg2;
PFont buttonFont;
Button start;
Button restart;

boolean theplay=false;
boolean gameover=false;

void setup (){
size (390,600);

img = loadImage ("ground.png");
img3 = loadImage ("background.png");
imgbg1 = loadImage ("endbg.png");
imgbg2 = loadImage ("end.png");
imgintro = loadImage ("introback.png");

minim = new Minim (this);
buttonsound = minim.loadSnippet ("button.mp3");
buttonrestart = minim.loadSnippet ("buttonrestart.mp3");
bgm = minim.loadSnippet ("wings.mp3");
for (int i=0; i < 8; i++){
   ladders[i] = new Ladder (random(20,300), 515-i*65);
}
for (int i=0; i<floors.length;i++){
   floors [i] = new Floor (0,510-i*65);
}
 ladders [8] = new Ladder (-20,-20);

rolePikachu = new Role (20, 550);
frameRate (30);

timer = new Timer(25);
 
startScreen();
}

void draw (){

  if (theplay==true && gameover==false){
  play();
  }
  
    
  
}

//void keyTyped(){
//  if (key==' '){
//    if(rolePikachu.isJumping==false){       
//        rolePikachu.isJumping=true;
//        rolePikachu.speedY=3;  
//    }  
//  }
//} 

void startScreen (){
  bgm.rewind();
  bgm.play();
image(imgintro,0,0);
buttonFont = loadFont("CourierNewPS-BoldMT-20.vlw");
textFont (buttonFont);
fill (0);
text ("Introduction:\n 1. Use arrow keys to move\n 2. Use UP arrow key to climb\n 3.Let's see how far you will go!\n\n\n Have Fun! ", 20,50,350,500);
start = new Button (290,500,80,40,"Start");
start.display();
}

void endGame(){
image (imgbg1,0,0);
image (imgbg2, 30, 300);
buttonFont = loadFont("CourierNewPS-BoldMT-20.vlw");
textFont (buttonFont);
text ("You've climbed to floor "+(rolePikachu.layer+1),50,50);
restart = new Button(150,500,90,40,"Restart");
restart.display();
}

void play(){
background (255);

timer.finish();

image (img3,0,-350);
image (img, 0, 490);
for (int i=0;i<8;i++){
  ladders[i].display();
}

for (int i=0;i<floors.length;i++){
  floors[i].display();
} 

rolePikachu.display();
rolePikachu.move();
fill (0);

text ("floor: "+( rolePikachu.layer + 1),250,20);
text ("Time: " + (25-timer.passedTime/1000), 20,20);
if (25-timer.passedTime/1000==0 || 25-timer.passedTime/1000<0 ||rolePikachu.layer==8){
endGame();
gameover=true;
theplay=false;



}

}

void mousePressed(){
  if(theplay==false && gameover==false){
      if (start.isClicked(mouseX, mouseY,buttonsound,buttonsound)){
             theplay =true;
            timer.start();
      }
  }else
  
      if (theplay==false && gameover==true){
        if (restart.isClicked (mouseX,mouseY,buttonrestart,buttonrestart)){
                     theplay = false;
                     gameover=false;
                     rolePikachu.rY=550;
                     rolePikachu.rX=10;
    startScreen();
  }
}
  

}

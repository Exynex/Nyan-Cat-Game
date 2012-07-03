/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/62166*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/55794*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

//imports
import ddf.minim.*;
import gifAnimation.*;


Player player; // player
int num_enemys = 30; //number of enemies currently on
Enemy[] enemies = new Enemy[num_enemys]; //array of enemies created

boolean gameLoop = false; // main game loop
boolean gameOver = false;
boolean mainMenu = true;
boolean selections = false;

// collision detection
boolean _DEBUG_ = false;
boolean _CIRCLE_HITTEST_ = false;
boolean _SQUARE_HITTEST_ = true;
//buttons
// int for easy input and modifing
int lolb = 520;
int lolt = 530;

//Button(int xPos, int yPos, int xSize, int ySize, String ln, int xPos2, int yPos2)screen is 980x480
Button replay = new Button(200, 250, 220, 50, "Replay", 255, 290);
Button main   = new Button(200, 325, 220, 50, "Main Menu", 210, 365);
Button start  = new Button(200, 325, 220, 50, "Start Game", 210, 365);
Button select  = new Button(10, 422, 960, 50, "Choose Kitty", 410, 460); // order of buttons
Button G1 = new Button(100, 170, 170, 50, "Normal", 110, 210);  //   normal | ninja
Button G2 = new Button(lolb, 170, 170, 50, "Ninja", lolt, 210);   // american | hipster
Button G3 = new Button(100, 240, 170, 50, "American", 110, 280);//  mexican | evil
Button G4 = new Button(lolb, 240, 170, 50, "Hipster", lolt, 280); //  french  | chinese
Button G5 = new Button(100, 310, 170, 50, "Mexican", 110, 350);  //  
Button G6 = new Button(lolb, 310, 170, 50, "soon..", lolt, 350);  //   
Button G7 = new Button(100, 380, 170, 50, "soon..", 110, 420);  // 
Button G8 = new Button(lolb, 380, 170, 50, "soon..", lolt, 420); //   
// time variables
int count = 0;
int countControl = 0;
int time = 0;
int minutes = 0;
String score = "";
//variables
color clr;
int startingSpeed = 2;
int speed = startingSpeed;
//randomizer
float angle = random(-5, 5);

//font, images, and sounds
PFont font;
Minim mini;
AudioSample nyancatmusic;
//fat cat in the main menu
PImage nyanmenu;
//players only needed for using out of the actual gameplay
PImage nynormal;
PImage nyninja;
PImage nyamerican;
PImage nyhipster;
PImage nymexican;
//int for the size of the cats in the chose menu
int catfatx = 75;
int catfaty = 45;


//trail int
SpectrumTrail Trail;
//colors for trails
color trailColorOne;
color trailColorTwo;
color trailColorThree;
color trailColorFour;
color trailColorFive;
color trailColorSix;

//color americanColor;
//color normalColor;
void setup() {
  size(980, 480);
  smooth();
  //trails
  Trail = new SpectrumTrail();
 
  //color
  clr = color(0, 0, 255);
  //normalColor = (0);
  //americanColor = color(255);
  // font
  font = loadFont("font.vlw");
  //sounds
  mini = new Minim(this);  
  nyancatmusic = mini.loadSample("nyancat.mp3", 2048);
  // create enemys
  for (int i = 0; i < num_enemys; i++) {
    enemies[i] = new Enemy();
    nyanmenu = loadImage("nyancat.gif");
    //load all the out of gameplay nayn cats
    nynormal = loadImage("Nyan-cat.png");
    nyninja = loadImage("tinynyaninja.png");
    nyamerican = loadImage("americakittynot.png");
    nyhipster = loadImage("hipster.png");
    nymexican = loadImage("mexican.png");
  }
  // create player
  player = new Player(mouseX-25, mouseY-16, 50, 32);
 
  
}



//drawing loop begins here
public void draw() {
  //draws trail
   

  fill(255);
  textFont(font, 30);
  stroke(100);
  strokeWeight(4);

  //////////////
  // Main menu//
  //////////////
  if ( mainMenu ) {

    background(255);
    fill(0, 0, 255, 170);
    rect(200, 20, 600, 110); //(xPos, yPos, xFat, yFat)
    fill(255);
    text("Welcome to the Nyan Game! \n don't let your kitty get hit!", 295, 70);
    image(nyanmenu, 300, 140); // (xPos, yPos)
    select.draw();
    
    if ( select.clicked ) {
      select.clicked = false;
      selections = true;
      mainMenu = false;
    }
  }

  ////////////////////
  // Game Selections//
  ////////////////////
  if ( selections ) {
    background(200);
    fill(0, 0, 255, 170);
    rect(290, 10, 430, 100);
    fill(255);
    text("Choose your nyan! :D", 360, 70); //for img: image("name"xPos, yPos, xFat, yFat)
    //these are the buttons!:    these are the pictures of the buttons:
    G1.draw(); G2.draw();        image(nynormal, 360, 170, catfatx, catfaty);          image(nyninja, 800, 170, catfatx, catfaty);
    G3.draw(); G4.draw();        image(nyamerican, 360, 240, catfatx, catfaty);        image(nyhipster, 800, 240, catfatx, catfaty);
    G5.draw(); G6.draw();        image(nymexican, 360, 315, catfatx, catfaty);         //image(nyfrench, 800, 280, catfatx, catfaty);
    G7.draw(); G8.draw(); 

    
    // nyan mode
    if ( G1.clicked ) {

      G1.clicked = false;
      selections = false;
      gameLoop = true;
      // set sprite images
      player.setSpriteImage("Nyan-cat.png");
      setEnemySpriteImage("nyanstar.png");
      nyancatmusic.trigger();
    } 
    // ninja mode
    if ( G2.clicked ) {
      G2.clicked = false;
      selections = false;
      gameLoop = true;
      // set sprite images
      player.setSpriteImage("tinynyaninja.png");
      setEnemySpriteImage("tinytinystar.png");
      nyancatmusic.trigger();
    } 
    // american mode
    if ( G3.clicked ) {
      G3.clicked = false;
      selections = false;
      gameLoop = true;
      // set sprite image
      player.setSpriteImage("americakittynotsm.png");
      setEnemySpriteImage("hamsickle.png");
      nyancatmusic.trigger();
      
    } 
    // hipster mode
    if ( G4.clicked ) {
      G4.clicked = false;
      selections = false;
      gameLoop = true;
      // set sprite images

      player.setSpriteImage("hipstery.png");
      setEnemySpriteImage("sunglassest.png");
      nyancatmusic.trigger();
      
    }
    //mexican
    if ( G5.clicked ) {
      G5.clicked = false;
      selections = false;
      gameLoop = true;
      // set sprite images
      player.setSpriteImage("mexican.png");
      setEnemySpriteImage("burrito.png");
      nyancatmusic.trigger();
    }
    
  }

  //////////////
  // Game Loop//
  //////////////
  if (gameLoop) {

    background(17, 67, 116);
    noStroke();

    // update score and draw
    updateScore();
    drawScore();

    // update enemy positions and draw    
    for (int i = 0; i < num_enemys; i++) {
      enemies[i].update();
      enemies[i].draw();
    }    

    // update player position and draw
    player.pos.x = mouseX;
    player.pos.y = mouseY;    
    player.draw();

    // do collision detect for player+enemies   
    collisionDetect();
  }


  /////////////////
  ////GAME OVER////
  /////////////////
  if ( gameOver ) {
    if ( gameLoop ) {
      gameLoop = false; 
      nyancatmusic.stop();
    }
    background(230);
    fill(255, 0, 0, 170);
    rect(150, 70, 330, 80);
    rect(230, 150, 160, 70);
    fill(255);
    text("Game Over!", 200, 125);

    if (time < 10) {
      text(minutes + ":0" + time, 265, 205);
    }
    else {
      text(minutes + ":" + time, 265, 205);
    }
    replay.draw();
    main.draw();
    if ( replay.clicked ) {
      replay.clicked = false;
      speed = startingSpeed;
      clr = color(0, 0, 255);
      gameOver = false;
      mainMenu = false;
      gameLoop = true;
      count = 0;
      minutes = 0;      
      nyancatmusic.trigger();
    }
    if ( main.clicked ) {
      main.clicked = false;
      selections = true;
      gameLoop = false;
      gameOver = false;
      count = 0;
      minutes = 0;
    }
  }
  
}
//update the projectile's speed
void updateSpeed() {
  speed += 1;
  angle = random(-10, 10);
  clr = color(random(0, 255), 100, 100);
}
//collision detection
void collisionDetect() {
  for (int i = 0; i < num_enemys; i++) {
    if ( player.hitTest( (Sprite) enemies[i]) ) { 
      gameOver = true;
    }
  }
}
 //set enemy sprite image
void setEnemySpriteImage(String spriteImageLoc) {
  for (int i = 0; i < num_enemys; i++) {
    enemies[i].setSpriteImage(spriteImageLoc);
  }
}
//update score
void updateScore() {
  if (countControl != second() ) {
    countControl = second();
    count++; 
    time = count;
    if (time % 13 == 0) {
      updateSpeed();
    }
  }    
  if (time == 60) {
    minutes += 1; 
    time = 0; 
    count = 0;
  }
  score = minutes + ":" + time;
}
//draw score
void drawScore() {
  if (time < 10) {
    text(minutes + ":0" + time, 30, 60);
  }
  else {
    text(minutes + ":" + time, 30, 60);
  }
}
//mouse click checker
void mouseClicked() {
  if (_DEBUG_) {
    println("MouseX: " + mouseX + " -- " + "MouseY: " + mouseY);
    println(mousePressed);
  }
  if ( mainMenu ) {
    select.mouseClicked();
  }
  if ( selections ) {
    G1.mouseClicked();
    G2.mouseClicked();
    G3.mouseClicked();
    G4.mouseClicked();
    G5.mouseClicked();
  }
  if ( gameOver ) {
    replay.mouseClicked();
    main.mouseClicked();
  }
  
}

class Button {

  int x;
  int y;
  int sx;
  int sy;
  String txt;
  int x2;
  int y2;

  boolean clicked = false;

  Button(int xPos, int yPos, int xSize, int ySize, String ln, int xPos2, int yPos2) {
    x   = xPos;
    y   = yPos;
    sx  = xSize;
    sy  = ySize;
    txt = ln;
    x2  = xPos2;
    y2  = yPos2;
  }

  void draw() {
    
    if (mouseX > x && mouseX < x + sx &&
      mouseY > y && mouseY < y + sy) {
      stroke(100);
      fill(0, 0, 255, 175);
    }
    else {
      stroke(100);
      fill(0, 255, 0, 175);
    }
    rect(x, y, sx, sy);
    fill(255);
    text(txt, x2, y2);
  }

  void mouseClicked() {
    if (mouseX > x && mouseX < x + sx && mouseY > y && mouseY < y + sy) {
      clicked = true;
    }
  }
}
class Enemy extends Sprite {

  PImage enemyImage;
  float speedVar;

  //default
  Enemy() {
    super();
    radius = 6;
    pos = new PVector(random(0, width), random(0, height));
    speedVar = random(0.5, 1.5);
  }

  //update enemy position
  void update() {
    // set position
    if ( pos.x > 0 )
      pos.add(new PVector(-speed * speedVar, 0));
    else
      pos.set(width, random(0, height), 0);
  }
  //Set enemy sprite image 
  void setSpriteImage(String imageLocation) {
    enemyImage = loadImage(imageLocation);
  }
  //draw enemy
  void draw() { 
    // draw debug
    if (_DEBUG_) {
      drawRectBounds(pos, enemyImage.width, enemyImage.height);
    }
    image(enemyImage, super.pos.x, super.pos.y);
    
  }
  boolean hitTest( Sprite test ) {
    if (_CIRCLE_HITTEST_) {
      return circleCollision(this.pos, this.radius, test.pos, test.radius);
    } 
    else if (_SQUARE_HITTEST_) {
      return rectCollision(this.pos, this.radius, test.pos, test.radius);
    } 
    else {
      return false;
    }
  }
}


boolean circleCollision(PVector pos1, float radius1, PVector pos2, float radius2) {
  final double a  = radius1 + radius2;
  final double dx = pos1.x - pos2.x;
  final double dy = pos1.y - pos2.y;
  return a * a > (dx * dx + dy * dy);
}


boolean rectCollision(PVector pos1, float radius1, PVector pos2, float radius2) {
  return pos1.x - radius1 <= pos2.x + radius2 && pos1.x + radius1 >= pos2.x - radius2 &&
    pos1.y - radius1 <= pos2.y + radius2 && pos1.y + radius1 >= pos2.y - radius2;
}


void drawBounds(PVector pos, float radius) {
  noFill();
  strokeWeight(1);
  stroke(255, 255, 0);

  if (_CIRCLE_HITTEST_) {
    ellipse(pos.x, pos.y, radius*2, radius*2);
  } 
  if (_SQUARE_HITTEST_) {
    float rect_size = radius*2;
    rect(pos.x - rect_size/2, pos.y - rect_size/2, rect_size, rect_size);
  }
}

void drawRectBounds(PVector pos, float w, float h) {
  noFill();
  strokeWeight(1);
  stroke(255, 255, 0);
  rect(pos.x, pos.y, w, h);
}
class Particle {

  PVector pos, vel;

  Particle() {
    pos = new PVector(); // position vector
    vel = new PVector(); // velocity vector
  }
}
class Player extends Sprite {

  PImage playerImage;
  
  //default
  Player() {
    super();    
  }
  Player(int a, int b, int c, int d) {
    super();
    rect(a, b, c, d); //size of a rectangular sprite
  }

  //hit test of player
  boolean hitTest( Sprite test ) {
      return rectCollision(this.pos, this.radius, test.pos, test.radius);
  }
  //Set the player sprite image 
  
  void setSpriteImage(String imageLocation) {
    playerImage = loadImage(imageLocation);
    //super.width = playerImage.width;
    //super.height = playerImage.height;
  }
  
  //draw the player sprite
  void draw() {    
    if (_DEBUG_) {
      drawBounds(pos, radius);
    }
         
    image(playerImage, mouseX-25, mouseY-16);
    Trail.draw(mouseX, mouseY); 
    
  }
}










/*
trails WIP  float[] trailx = new float[25];
  //  float[] traily = new float[25];  


// constructor
    
     for (int i = 0; i < trailx.length; i ++ ) {
     trailx[i] = 0; 
     traily[i] = 0;
     }
    


// draw loop
     
     // Shift array values for trail
     for (int i = 0; i < trailx.length-1; i ++ ) {
     trailx[iz] = trailx[i+1];
     traily[i] = traily[i+1];
     }    
     noStroke();
     //fill(255, 0, 0);
     //ellipse(pos.x, pos.y, 5, 5);
     // set trail head to new the new location
     trailx[trailx.length-1] = pos.x; 
     traily[traily.length-1] = pos.y;      
     // Draw trails
     noFill();
     strokeWeight(4);
     int trailLength = trailx.length;
     for (int i = 1; i < trailLength; i ++ ) {
     // Draw an ellipse for each element in the arrays. 
     // Color and size are tied to the loop's counter: i.
     stroke(255,0,0);
     line(trailx[i], traily[i], trailx[i-1], traily[i-1]);
     }        
     endShape();
     

*/

class SpectrumTrail {

  // position
  PVector p;

  // trails
  PVector[] trails;
  int trailLength = 20;

  // settings
  float trailHeight = 30;  
  float speed = 0.1;
  float amp = 10.0;
  float thickness = 6;
  float xDir = 4.0;


  // colors
  color[] colors;

 SpectrumTrail() {

    // position vector
    p = new PVector();

    // init colors
     //color for trails
        trailColorOne = color(255, 18, 21); 
        //trailColorOne = color(normalColor);
        trailColorTwo= color(255, 168, 10);
        trailColorThree = color(255, 255, 10);
        trailColorFour = color(60, 255, 13);
        trailColorFive = color(20, 171, 255);
        trailColorSix = color(118, 68, 255);
         //if (G3.clicked){trailColorOne = color(americanColor);}
        /* 
          fail to change color. 
          if (G5.clicked){ trailColorOne = color(0);}
          G5.clicked function on the mauin void draw failed too
        */
    colors = new color[6];
    colors[0] = color(trailColorOne); 
    colors[1] = color(trailColorTwo);
    colors[2] = color(trailColorThree);
    colors[3] = color(trailColorFour);
    colors[4] = color(trailColorFive);
    colors[5] = color(trailColorSix);

    // init trails
    trails = new PVector[trailLength];
    for (int i = 0; i < trailLength; i++)
      trails[i] = new PVector(0, 0);
  }



  void draw(float _x, float _y) {

    strokeWeight(thickness);

    // set position
    p.x = _x-17;
    p.y = _y + (sin(frameCount * speed) * amp);

    // offset trail from last position in the array, backwards
    // this needs to happen before the trail head is set
    for (int i = 0; i < trailLength-1; i++ ) {
      trails[i].set(trails[i+1]);
      trails[i].x -= xDir;
    }

    // set trail head to position
    trails[trailLength-1].set(p);

    // draw color trails
    // TODO: fade out trails
    for (int c = 0; c < colors.length; c++) {
      stroke(colors[c]);
      for (int i = trailLength-2; i >= 0; i-- ) {
        float offset = trailHeight / colors.length * (c+1) - (trailHeight/2);
        line(trails[i].x, trails[i].y + offset, trails[i+1].x, trails[i+1].y + offset);
      }
    }
  }
}
class Sprite extends Particle {
  float radius;

  Sprite() {
    super();
    radius = 16;
  }

  Sprite(int a, int b, int c, int d) {
    super();
    rect(a, b, c, d);
  }

  boolean hitTest( Sprite test ) {
    if (_CIRCLE_HITTEST_) {
      return circleCollision(this.pos, this.radius, test.pos, test.radius);
    } 
    else if (_SQUARE_HITTEST_) {
      return rectCollision(this.pos, this.radius, test.pos, test.radius);
    } 
    else {
      return false;
    }
  }
}




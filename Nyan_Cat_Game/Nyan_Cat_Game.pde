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
Button G6 = new Button(lolb, 310, 170, 50, "Russian", lolt, 350);  //   
Button G7 = new Button(100, 380, 170, 50, "Chinese", 110, 420);  // 
Button G8 = new Button(lolb, 380, 170, 50, "French", lolt, 420); //   
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
PImage nyrussian;
PImage nychinese;
PImage nyfrench;
//int for the size of the cats in the chose menu
int catfatx = 75;
int catfaty = 45;


//trail int
SpectrumTrail Trail;
//colors for trails
int trailColorOne = 0;
color trailColorTwo;
color trailColorThree;
color trailColorFour;
color trailColorFive;
color trailColorSix;

//color americanColor;
//color normalColor;


//different cats
boolean G1Normal = false;


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
    nyrussian = loadImage("russian.png");
    nychinese = loadImage("chinese.png");
    nyfrench = loadImage("french.gif");
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
    G5.draw(); G6.draw();        image(nymexican, 360, 315, catfatx, catfaty);         image(nyrussian, 800, 315, catfatx+5, catfaty+5);
    G7.draw(); G8.draw();        image(nychinese, 360, 400, catfatx, catfaty);         image(nyfrench, 800, 400, catfatx, catfaty);

    
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
    //russian
    if (G6.clicked) {
     G6.clicked = false;
     selections = false;
     gameLoop = true;
     player.setSpriteImage("russian.png");
     setEnemySpriteImage("bomb.png");
     nyancatmusic.trigger();
    }
    if(G7.clicked){
     G7.clicked = false;
     selections = false;
     gameLoop = true;
     player.setSpriteImage("chinese.png");
     setEnemySpriteImage("bomb.png");
     nyancatmusic.trigger(); 
    }
    if(G8.clicked){
      G8.clicked = false;
      selections = false;
     gameLoop = true;
     player.setSpriteImage("french.gif");
     setEnemySpriteImage("bomb.png");
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
         if (G1Normal){ trailColorOne = color(255); } 
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
    G6.mouseClicked();
    G7.mouseClicked();
    G8.mouseClicked();
  }
  if ( gameOver ) {
    replay.mouseClicked();
    main.mouseClicked();
  }
  
}


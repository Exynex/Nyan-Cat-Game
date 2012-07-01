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


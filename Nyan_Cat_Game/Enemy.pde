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


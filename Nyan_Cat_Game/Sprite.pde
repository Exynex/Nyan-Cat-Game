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



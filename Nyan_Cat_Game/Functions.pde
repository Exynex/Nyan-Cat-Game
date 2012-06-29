
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

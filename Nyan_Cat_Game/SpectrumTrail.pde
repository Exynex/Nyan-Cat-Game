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

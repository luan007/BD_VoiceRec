
float cPerspective = 1;
float tPerspective = 1;
float ePerspective = 0.2;
PImage phoneBg;

void initPhone() {
}

void setPerspective(float p) {
  tPerspective = p;
}

void drawPhone() {
  
  if(mousePressed || (cur != null && cur.annotation == "Vocal")) {
    setPerspective(1);
  } else {
    setPerspective(0);
  }
  cPerspective = ease(cPerspective, tPerspective, ePerspective);
  float mPerspective = pow(cPerspective, 0.5);
  float rotation = 30 * mPerspective;
  float translation = 90 * mPerspective;
  float size = 0.7;
  float stage1 = mPerspective * 30;
  float stage2 = mPerspective * mPerspective * 30;
  float glow = mPerspective;

  pushMatrix();
  rectMode(CENTER);
  translate(1920 / 2, 1080 / 2);
  
  rotateX(radians(rotation * 1.5));
  rotateY(-radians(rotation));
  //intro.update();
  
  scale(size);



  noFill();
  noStroke();
  fill(30);
  rect(0, 0, 485, 1014, 82); //outer
  noFill();
  strokeWeight(3);
  stroke(#2fafff, 100);
  rect(0, 0, 485, 1014, 82); //outer
  translate(0, 0, stage1);
  rect(0, 0, 475, 1005, 75); //inner

  //ellipse(0, -475, 23, 23); //
  ellipse(0, 447, 70, 70); //btn
  ellipse(0, 447, 80, 80); //btn out
  ellipse(-80, -445, 10, 10); //cam
  ellipse(-80, -445, 13, 13); //cam out

  translate(0, 0, stage1);
  rect(0, -445, 85, 10, 82); //headphone
  translate(0, 0, stage2);
  rect(0, 0, 439, 780, 3); //screen
  translate(0, 0, stage2);

  if (img != null) {
    imageMode(CENTER);
    image(img, 0, 0, 439, 780);
    imageMode(CORNER);
  }
  rect(0, 0, 445, 787, 4); //screen - deco

  pushMatrix();
  blendMode(ADD);
  strokeWeight(3);
  for (float i = 0; i < 40; i++ ) {
    translate(0, 0, 2*i / 5 * glow);
    stroke(#2fafff, (40 - i) * noise((float)millis() / 400) * 2 * glow);
    rect(0, 0, 445, 787, 4); //screen - deco
  }
  popMatrix();

  //  pushMatrix();
  //  translate(-439 / 2, -780 / 2);
  //  float step = 90;
  //  float offset = -(float(millis()) / 4) % step + step;
  //  for (float i = 0; i < 439; i += step / 2) {
  //    for (float j = 0; j < 780; j += step) {
  //      float t = float(millis()) / 1000;
  //      float x = i;
  //      float y = 780 - j + offset;
  //      float sz = noise(x / 100, y / 100, t) * sin(y / 780 * PI);
  //      float blink =  noise(x / 51, y / 51, t) * sin(y / 780 * PI);
  //      pushMatrix();
  //      translate(x, 
  //        ((noise(x / 10, y / 500, t / 100) - 0.5) * 600 + 350) * mPerspective, y);
  //      fill(255, sz * 255);
  //      scale(sz * mPerspective);
  //      //rotate(PI / 4);
  //      noStroke();
  //      rect(0, 0, 20, 20);
  //      //text("\"", 0, 0);
  //      popMatrix();
  //    }
  //  }
  //  popMatrix();
  
  
  blendMode(BLEND);
  translate(0, 200, 50 + 350 * mPerspective);
  popMatrix();
  drawSpace();
}
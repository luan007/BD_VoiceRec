PGraphics letter;
PFont font;
PFont pFont;
//String l = "S"; 
//int SCALER = 10;
//flowField field;
txtField txt;
//PGraphics yayfield;

void shoutOut(String word) {
  txt.toss = word;
  txt.eject = 50;
}

void setupVfx() {
  //letter = createGraphics(int(1920 / SCALER), int(1080 / SCALER));
  //font = createFont("PingFang SC", 80);
  pFont = createFont("PingFangSC-Semibold", 30);
  /*field = new flowField();
   yayfield = createGraphics(1920, 1080, OPENGL);
   */
  txt = new txtField();
  //frameRate(1);
}

void drawVfx() {

  /*
  yayfield.beginDraw();
   yayfield.hint(DISABLE_DEPTH_TEST);
   
   yayfield.fill(0, 150);
   yayfield.rect(0, 0, 1920, 1080);
   
   yayfield.translate(1920 / 2, 1080 / 2);
   
   float mPerspective = pow(cPerspective, 0.5);
   float rotation = 30 * mPerspective;
   
   yayfield.rotateX(radians(rotation * 1.5));
   yayfield.rotateY(-radians(rotation));
   
   yayfield.translate(-1920 / 2, -1080 / 2);
   
   yayfield.blendMode(ADD);
   field.update();
   yayfield.blendMode(BLEND);
   yayfield.endDraw();
   blendMode(ADD);
   //image(yayfield, 0, 0);
   blendMode(BLEND);
   */

  pushMatrix();
  translate(1920 / 2, 1080 / 2, 0);
  txt.update();
  popMatrix();
}

/*
public class flowField extends psys<flow> {
 float MAX = 6000;
 flowField() {
 for (int i = 0; i < MAX; i++) {
 flow f = (new flow(letter));
 //f.p = new PVector(-10, random(0, 1080), 0);
 f.reborn();
 
 f.p.x = random(0, 1920);
 this.add(f);
 }
 }
 
 
 void onupdate() {
 letter.beginDraw();
 letter.textFont(font);
 letter.textAlign(CENTER, CENTER);
 letter.background(0);
 letter.translate(letter.width / 2, letter.height / 2);
 letter.fill(255);
 if (mousePressed) {
 letter.text("我", 0, -10);
 } else {
 letter.text("不", 0, -10);
 }
 letter.endDraw();
 //image(letter, 330, 330);
 letter.loadPixels();
 //int l = letter.pixels.length;
 }
 }
 
 public class flow extends p {
 float vRand = random(10, 20);
 float sz;
 pinertField inert;
 
 flow (PGraphics in) {
 inert = new pinertField(this);
 inert.texture = in;
 }
 
 void reborn() {
 p = new PVector(-10, random(0, 1080), random(-30, 30));
 sz = random(1);
 vRand = random(10, 20);
 v.x = 10;
 v.y = 0;
 }
 void onupdate() {
 this.v.x = ease(this.v.x, vRand);
 if (this.p.x > 2000) {
 this.reborn();
 }
 }
 
 void render() {
 yayfield.pushMatrix();
 yayfield.translate(p.x, p.y, p.z);
 yayfield.scale(this.sz);
 yayfield.fill(255, this.inert.o);
 yayfield.rect(0, 0, 5, 5);
 yayfield.popMatrix();
 }
 }
 public class pinertField extends behavior {
 float rate = 0.1;
 float damper = 0.8;
 int div = SCALER;
 PGraphics texture;
 float o = 0;
 pinertField(p p) { 
 super(p);
 this.stage = pstage.init;
 }
 void update(int stage) {
 if (texture == null) return;
 int x = int(max(0, min(1, (float)this.p.p.x / 1920)) * (this.texture.width - 1));
 int y = int(max(0, min(1, (float)this.p.p.y / 1080)) * (this.texture.height - 1));
 color c = texture.pixels[(x) + (y) * this.texture.width];
 o = 20 + brightness(c) / 8;
 this.p.v.mult(1 - brightness(c) / 255 / 5);
 }
 }
 */









class txtField extends psys<txt> {
  txtField() {
    autoClean = true;
  }

  String toss = null;
  int eject = 0;

  void onupdate() {
    if (this.toss != null && eject > 0) {
      eject--;
      add(this.toss);
    }
  }

  void add(String s) {
    txt t = new txt();
    t.p = new PVector(random(-1920 / 2, 1920 / 2), random(-1080 / 2, 1080 / 2), -1000);

    t.v = new PVector(0, 0, random(5, 30));
    t.t = s;
    t.l = 1;
    t.vl = random(0.01, 0.03);
    this.add(t);
  }
}

class txt extends p {
  String t;
  void render() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    textFont(pFont);
    float opa = sin(this.l * PI);
    fill(255, 255 * opa);
    noStroke();
    rectMode(CENTER);
    text(this.t, 0, 0);
    textAlign(CENTER, CENTER);
    stroke(50, 150, 255, opa * 255 * (sin(50 * l) * 0.5 + 0.5));
    fill(50, 150, 255, opa * 30 * (cos(8 * l) * 0.5 + 0.5));
    rect(0, 6, textWidth(this.t) + 20, 50);
    noStroke();
    for (int i = 0; i < 5; i++) {
      translate(0, 0, -10);
      rect(0, 6, textWidth(this.t) + 20, 50);
    }
    popMatrix();
  }
}
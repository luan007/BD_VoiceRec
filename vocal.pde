
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fftLin;



void drawSpace() {
  pushMatrix();
  blendMode(ADD);
  translate(1920 / 2, 1080 / 2, 0);
  stroke(255, 10);
  noFill();
  strokeWeight(1);
  box(1920, 1080, cPerspective * 800);

  drawVocalLines();
  image(waveFBO, -1920 / 2, -1080 / 2);

  blendMode(BLEND);
  popMatrix();
}
PGraphics waveFBO;
void setupWave() {
  waveFBO = createGraphics(1920, 1080, OPENGL);

  minim = new Minim(this);

  in = minim.getLineIn();
  fftLin = new FFT( in.bufferSize(), in.sampleRate() );
  fftLin.logAverages( 22, 3) ;
}
float avg = 0;
float cavg = 0;
float[] bands = new float[10];
float[] cbands = new float[10];
float _off = 0;
void drawVocalLines() {
  fftLin.forward( in.mix );
  avg = 0;
  bands = new float[10];
  int bandSnap = fftLin.specSize() / (bands.length - 1);
  for (int i = 0; i < fftLin.specSize(); i++)
  {
    bands[floor(i / bandSnap)] += fftLin.getBand(i);
    float b = fftLin.getBand(i);
    avg += b;
  }
  avg /= fftLin.specSize();
  cavg = ease(cavg, avg);
  for (int i = 0; i < bands.length; i++) {
    bands[i] /= float(bandSnap);
    cbands[i] = ease(cbands[i], bands[i], 0.2);
  }
  float step = 0.02;
  waveFBO.beginDraw();
  waveFBO.noStroke();
  waveFBO.pushMatrix();
  waveFBO.fill(0, 150 - cavg * 20);
  waveFBO.translate(1920 / 2, 1080 / 2, -800);
  waveFBO.rectMode(CENTER);
  waveFBO.rect(0, 0, 1920 * 3, 1080 * 3);
  waveFBO.popMatrix();
  waveFBO.noFill();
  waveFBO.blendMode(ADD);
  waveFBO.pushMatrix();
  waveFBO.translate(1920 / 2, 1080 / 2, 0);

  float mPerspective = pow(cPerspective, 0.5);
  float rotation = 30 * mPerspective;
  waveFBO.rotateX(radians(rotation * 1.5));
  waveFBO.rotateY(-radians(rotation));

  _off -= 0.1 * cavg;
  for (int i = 0; i < 4; i++) {
    waveFBO.pushMatrix();
    waveFBO.translate(0, 0, cPerspective * 130);
    waveFBO.strokeWeight((i + 1) * 2);
    waveFBO.beginShape();
    float off = _off;
    for (float e = -1; e <= 1; e += step) {
      waveFBO.stroke(100 * cavg, 30 * avg, 100 * avg, max(0, 1 - abs(e) * 1.1) * 255);
      float v = sin(e * 1000 * cavg + off / 2) / 10 * cavg + cos(e * 10 + off * 2) * sin(e * 1 + off) * sin(e * cavg * cavg + off) * min(1, (cbands[i]));
      float u = cos(e * 10 + off * 2) * sin(e * 1 + off);
      float x = e * 800;
      v = v * 200 * (e) * cavg + 120;
      u = u * 300;
      waveFBO.curveVertex(x, v);
    }
    waveFBO.endShape();
    waveFBO.popMatrix();
  }


  for (int i = 0; i < 10; i++) {
    waveFBO.strokeWeight(2);
    waveFBO.beginShape();
    float off = -float(millis()) / (200 - i * 5)+ i * 10;
    for (float e = -1; e <= 1; e += step) {
      waveFBO.stroke(50, 150, 255, max(0, 1 - (abs(e) + 1 - cPerspective) * 1.1) * 255);
      float v = cos(e * 10 + off * 2) * sin(e * 1 + off);
      float u = cos(e * 10 + off * 2) * sin(e * 1 + off);
      float x = e * 800;
      v = v * 100 * (e) * cbands[i] + 120;
      u = u * 300;
      waveFBO.curveVertex(x, v);
    }
    waveFBO.endShape();
  }

  waveFBO.blendMode(BLEND);
  waveFBO.fill(0, 0, 0, (1 - cPerspective) * 255);
  waveFBO.translate(0, 0, 100);
  waveFBO.rect(0, 100, 300, 300);
  waveFBO.popMatrix();
  waveFBO.endDraw();
}
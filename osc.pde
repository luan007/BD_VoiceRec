import netP5.*;
import oscP5.*;

OscP5 oscP5;
void setupOsc() {
  oscP5 = new OscP5(this,12000);
}


void oscEvent(OscMessage msg) {
  if(msg.checkAddrPattern("/voice")==true) {
    try{
      shoutOut(new String(msg.get(0).blobValue(), "UTF-8"));
    }catch(Exception e) {
      println(e);
    }
    return;
  } 
  
}
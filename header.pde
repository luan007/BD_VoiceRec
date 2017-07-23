PFont titleFont;
PFont contentFont;

void initText() {
  String[] fontList = PFont.list();
  for (String f : fontList) { if (f.startsWith("Ping")) println(f); }
  titleFont = createFont("PingFangSC-Semibold", 30);
  contentFont = createFont("PingFangSC-Light", 20);
  tb = new textBlobs();
  tb.add(340, 220, "全平台REST API", "行业率先推出语音识别REST API，\n采用HTTP方式请求，\n可适用于任何平台的语音识别").p 
  = new PVector(1300, 600, 0);
  
  tb.add(400, 220, "离线在线融合模式", "SDK可以根据当前网络状况\n及指令的类型，自动判断使用本地引擎\n还是云端引擎进行语音识别").p 
  = new PVector(1300, 200, 0);
  
  tb.add(400, 250, "深度语义解析", "支持多达35个领域的语义理解，\n如：交通，社交，娱乐等。\n还可支持自定义指令集和问答对的设置，\n让您更准确地理解用户意图").p 
  = new PVector(300, 730, 0);
  
  tb.add(400, 220, "多垂直场景精确识别", "可自定义设置垂直领域的语音识别模型，\n现有音乐、视频、游戏等\n17个垂类可供选择，识别效果更精确").p 
  = new PVector(300, 100, 0);
  
  tb.add(340, 250, "自定义上传识别词库", "开发者可以自行上传词库，\n训练专属识别模型。\n提交的语料越多、越全，\n语音识别的效果提升也会越明显").p 
  = new PVector(250, 400, 0);
 }

textBlobs tb;
void renderText() {
  pushMatrix();
  translate(0, 30);
  tb.update();
  popMatrix();
}

class textBlob extends p {
  String title;
  String content;
  float h;
  float w;
  float rand = random(0, 1000);
  void render() {
    float viz = 1 - cPerspective;
    float v = viz * 255;
    float t = ((float)millis() / 1000) + rand;
    pushMatrix();
    translate(p.x, p.y + sin(t) * 10, p.z - cPerspective * 200);
    fill(255, v);
    //rect(0, 0, 300, 300);
    noFill();
    pushMatrix();
    
    translate(w / 2 - 20, h / 2 - 20);
    for(float z = 0; z < 1; z+= 0.1) {
      translate(0, 0, -z * 40 * viz);
      fill(255, (30 -  pow(abs(sin(t + z)), 2) * 30) * viz);
      stroke(255, (100 -  pow(abs(cos(t * 2 + z)), 1) * 100) * viz );
      rect(0, 0, w, h);
    }
    
    popMatrix();
    pushMatrix();
    translate(w / 2 - 20, h / 2 - 20);
    stroke(255, 250 * viz);
    fill(255, 255 * (abs(cos(t)) * 0.3 + 0.2) * viz);
    rect(0, 0, w, h);
    popMatrix();
    
    fill(50, 255 * viz);
    
    textAlign(LEFT, TOP);
    textFont(titleFont);
    text(title, 0, 0);
    textFont(contentFont);
    
    
    translate(0, 70);
    text(content, 0, 0);
    
    
    popMatrix();
  }
}

class textBlobs extends psys<textBlob> {
  textBlob add(float w, float h, String title, String content) {
    textBlob t = new textBlob();
    t.title = title;
    t.w = w;
    t.h = h;
    t.content = content;
    this.add(t);
    return t;
  }
}
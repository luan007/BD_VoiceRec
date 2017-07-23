float cdist(color c, color d) {
  return (abs(red(d) - red(c)) + abs(green(d) - green(c)) + abs(blue(d) - blue(d))) / 3.0;
}

boolean cd(color c, color d) {
  return cdist(c, d) < 2;
}

int sid = 0;
int prevState = -1;
int curState = -1;
int samples = 0;
state cur;

ArrayList<state> states = new ArrayList<state>();

class state {
  int id;
  String annotation;
  //color and pos
  color[] colors;
  int[] pos;
  boolean OR = false;
  state(int... cnp) {
    states.add(this);
    id = sid;
    sid = sid + 1;
    colors = new color[cnp.length / 3];
    pos = new int[cnp.length / 3 * 2];
    for (int i = 0; i < cnp.length; i += 3) {
      colors[i / 3]        = (color)cnp[i];
      pos[i / 3 * 2]       = cnp[i + 1] / checkBufDiv;
      pos[i / 3 * 2 + 1]   = cnp[i + 2] / checkBufDiv;
    }
  }
  boolean check() {
    for (int i = 0; i < colors.length; i++) {
      color c = checkBuf.get(pos[i * 2], pos[i * 2 + 1]);
      if (OR) {
        if (cd(c, colors[i])) { 
          return true;
        }
      } else {
        if (!cd(c, colors[i])) { 
          return false;
        }
      }
    }
    if (OR) {
      return false;
    }
    return true;
  }
}

state state(int... cnp) {
  return new state(cnp);
}

state state(String annotation, boolean OR, int... cnp) {
  state s = new state(cnp);
  s.OR = OR;
  s.annotation = annotation;
  return s;
}

void setState(state s) {
  int id = s == null ? -1 : s.id;
  if (curState != id) {
    samples++;
    if (samples > 1) {
      prevState = curState;
      curState = id;
      cur = s;
      println("Current State", id);
    }
  } else {
    samples = 0;
  }
}

void updateStates() {
  for (int i = 0; i < states.size(); i++) {
    state s = states.get(i);
    if (s.check()) {
      setState(s);
      return ;
    }
  }
  setState(null);
  return;
}

void setupStates() {
  state("App Menu", false, 
    -13269249,279,901,
    -513,403,901,
    -257,10,909
  );
  
  state("Vocal", true, 
    -13928471,99,909, //BTN_L
    -13269249,-394,912,
    -13269249,145,903
  );
}
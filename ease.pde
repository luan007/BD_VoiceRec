float E = 0.01;
float PREC = 0.0001;

float ease(float cur, float target) {
  if(abs(cur - target) < PREC) {
    return target;
  }
  return cur + (target - cur) * E;
}

float ease(float cur, float target, float E) {
  if(abs(cur - target) < PREC) {
    return target;
  }
  return cur + (target - cur) * E;
}
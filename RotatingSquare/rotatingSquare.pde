/*
UNFINISHED
*/

float w;
float ang;
float hw, hh;

class Data {
  public float len;
  public float rot;
}

Data cube(float plen, float prot, float dir) {
  float rw = (width - plen) / 2;
  float rh = (height - plen) / 2;
  
  pushMatrix();
  translate(hw, hh);
  float rot  = prot - ang;
  rotate(rot * dir);
  translate(-hw, -hh);
  translate(rw, rh);
  
  float nr = PI / 2 - rot;
  float nw = plen / (cos(nr) + sin(nr));
  rect((plen - nw) / 2, (plen - nw) / 2, nw, nw);
  popMatrix();
  
  Data data = new Data();
  data.len = nw;
  data.rot = nr;
  
  return data;
}

void setup() {
  size(600, 600);
  
  w = width;
  hw = width / 2;
  hh = height / 2;
}

void draw() {
  background(0);
  
  pushMatrix();
  translate((width - w) / 2, (height - w) / 2);
  noFill();
  stroke(255);
  strokeWeight(2);
  rect(0, 0, w, w);
  popMatrix();
  
  ang %= PI / 2;
  
  Data data = new Data();
  data = cube(w, 0, -1);
  data = cube(data.len, data.rot, 1);
  
  ang += PI/180;
}

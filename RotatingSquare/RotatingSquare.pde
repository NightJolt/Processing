float w;

float ang;

float hw, hh;

int cbc = 10;

int ld;

float minr = 100;

float maxr = 220;


class Data {

  public float len;

}


Data cube(float plen, float dir, color col) {

  float rw = (width - plen) / 2;

  float rh = (height - plen) / 2;

  

  pushMatrix();

  translate(hw, hh);
  
  rotate(ang * dir);

  translate(-hw, -hh);

  translate(rw, rh);

  

  float nr = PI / 2 - ang;

  float nw = plen / (cos(nr) + sin(nr));

  stroke(col);
  fill(col);

  rect((plen - nw) / 2, (plen - nw) / 2, nw, nw);

  popMatrix();

  

  Data data = new Data();

  data.len = nw;
  

  return data;

}


void setup() {

  //size(600, 600);

  

  w = width;

  hw = width / 2;

  hh = height / 2;

}


void draw() {

  //background(90, 0, 0);
  background(0);


  pushMatrix();

  translate((width - w) / 2, (height - w) / 2);

  fill(minr, 0, 0);

  stroke(minr, 0, 0);

  //strokeWeight(0);

  rect(0, 0, w, w);

  popMatrix();
  

  ang %= PI / 2;


  Data data = new Data();
  data.len = w;
  float red = (maxr - minr) / cbc;
  int dir = 0;
  ld = 1;
  
  for (int i = 1; i <= cbc; i++) {
    switch(ld) {
      case 1:
        ld++;
        dir = -1;
        break;
      case 2:
        ld++;
        dir = 0;
        break;
      case 3:
        ld++;
        dir = 1;
        break;
      case 4:
        ld = 1;
        dir = 0;
        break;
    }
    color col = color(100 + red * i, 0, 0);
    data = cube(data.len, dir, col);
  }


  ang += PI/720;

}

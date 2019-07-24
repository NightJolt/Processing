class Particle {
  PVector pos;
  Ray[] rays = new Ray[360 * 2];
  
  Particle() {
    this.pos = new PVector(width / 2, height / 2);
    for (int i=0;i<360*2;i++) {
      this.rays[i] = new Ray(pos, i * PI / (180 * 2));
    }
  }
  
  void update(float x, float y) {
    pos.set(x, y);
  }
  
  void lookAt(Boundary[] walls) {
    for (Ray ray : rays) {
      PVector closest = null;
      float record = Float.MAX_VALUE;
      for (Boundary wall : walls) {
        final PVector pt = ray.cast(wall);
        if (pt != null) {
          final float d = PVector.dist(pos, pt);
          if (d < record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (closest != null) {
        stroke(255, 100);
        line(pos.x, pos.y, closest.x, closest.y);
      }
    }
  }
  
  void show() {
    //fill(255, 0, 0);
    ellipse(pos.x, pos.y, 15, 15);
    /*for (Ray ray : rays) {
      ray.show();
    }*/
  }
}

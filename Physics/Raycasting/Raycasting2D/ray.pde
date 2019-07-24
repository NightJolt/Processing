class Ray {
  PVector pos, dir;
  
  Ray(PVector pos, float angle) {
    this.pos = pos;
    this.dir = new PVector(sin(angle), cos(angle));
  }
  
  void lookAt(float x, float y) {
    dir.x = x - pos.x;
    dir.y = y - pos.y;
    dir.normalize();
  }
  
  /*void show() {
    stroke(255);
    push();
    translate(pos.x, pos.y);
    line(0, 0, dir.x * 15, dir.y * 15);
    pop();
  }*/
  
  PVector cast(Boundary wall) {
    final float x1 = wall.a.x;
    final float y1 = wall.a.y;
    final float x2 = wall.b.x;
    final float y2 = wall.b.y;
    
    final float x3 = pos.x;
    final float y3 = pos.y;
    final float x4 = pos.x + dir.x;
    final float y4 = pos.y + dir.y;
    
    final float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) return null;
    
    final float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    final float u = ((y1 - y2) * (x1 - x3) - (x1 - x2) * (y1 - y3)) / den;
    
    if (t > 0 && t < 1 && u > 0) {
      final PVector pt = new PVector();
      
      pt.x = x1 + t * (x2 - x1);
      pt.y = y1 + t * (y2 - y1);
      
      return pt;
    } else {
      return null;
    }
  }
}

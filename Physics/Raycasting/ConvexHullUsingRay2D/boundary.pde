class Boundary {
  PVector a, b;
  Boolean usable = false;
  
  Boundary(PVector p1, PVector p2) {
    this.a = p1;
    this.b = p2;
  }
  
  void show() {
    push();
    if (usable) stroke(0, 255, 0); else stroke(0);
    if (usable || canDrawUnusable) line(a.x, a.y, b.x, b.y);
    pop();
  }
}

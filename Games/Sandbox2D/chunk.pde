class Chunk {
  final static int CHUNK_SIZE_X = 64;
  final static int CHUNK_SIZE_Y = 64;
  
  final static int TILE_SIZE = 5;
  
  final static int REAL_SIZE_X = CHUNK_SIZE_X * TILE_SIZE;
  final static int REAL_SIZE_Y = CHUNK_SIZE_Y * TILE_SIZE;
  
  int px = 0;
  int py = 0;
  
  Block[][] blocks;
  
  Chunk(int x, int y) {
    this.px = x;
    this.py = y;
    
    blocks = new Block[CHUNK_SIZE_X][CHUNK_SIZE_Y];
    fillChunk(new Air());
  }
  
  void show() {
    push();
    stroke(0, 255, 0);
    strokeWeight(2);
    rect(px, py, REAL_SIZE_X, REAL_SIZE_Y);
    pop();
    
    for (int x=0;x<CHUNK_SIZE_X;x++) {
      for (int y=0;y<CHUNK_SIZE_Y;y++) {
        blocks[x][y].show(px + x * TILE_SIZE, py + y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
      }
    }
  }
  
  void fillChunk(Block block) {
    for (int x=0;x<CHUNK_SIZE_X;x++) {
      for (int y=0;y<CHUNK_SIZE_Y;y++) {
        blocks[x][y] = block;
      }
    }
  }
  
  void setBlock(Block block, int x, int y) {
    if (x < 0 || x >= CHUNK_SIZE_X || y < 0 || y >= CHUNK_SIZE_Y) return;
    blocks[x][y] = block;
  }
}

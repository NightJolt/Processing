Chunk[][] chunks;

int chunk_x = 10;
int chunk_y = 10;

void setup() {
  size(856, 482);
  
  chunks = new Chunk[chunk_x][chunk_y];
  
  for (int x=0;x<chunk_x;x++) {
    for (int y=0;y<chunk_y;y++) {
      chunks[x][y] = new Chunk(Chunk.REAL_SIZE_X * x, Chunk.REAL_SIZE_Y * y);
    }
  }
  
  /*for (int x=0;x<64;x++) {
    final int altitude = floor(noise((float)x / 20) * 10) + 10;
    for (int y=altitude;y<altitude+4;y++) {
      setBlock(new Dirt(), x, y);
    }
  }*/
  
  chunks[0][0].fillChunk(new Dirt());
  chunks[1][0].fillChunk(new Dirt());
  chunks[0][1].fillChunk(new Dirt());
  chunks[1][1].fillChunk(new Dirt());
}

void draw() {
  background(210, 240, 255);
  
  for (int x=0;x<chunk_x;x++) {
    for (int y=0;y<chunk_y;y++) {
      chunks[x][y].show();    }
  }
}

void setBlock(Block block, int x, int y) {
  int cx = x / Chunk.CHUNK_SIZE_X;
  int cy = y / Chunk.CHUNK_SIZE_Y;
  
  x -= cx * Chunk.CHUNK_SIZE_X;
  y -= cy * Chunk.CHUNK_SIZE_Y;
  
  if (x < 0 || cx >= chunk_x || y < 0 || cy >= chunk_y) return;
  
  chunks[cx][cy].setBlock(block, x, y);
}

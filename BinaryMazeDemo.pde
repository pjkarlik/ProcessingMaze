/*
 *  Binary Maze creator
 *  Paul J Karlik | pjkarlik@gmail.com
 */  

// BinaryGenerator BinaryGenerator;

int cellSize = 50;
int rows = 12;
int cols = 12;
int cr = 2 * rows + 1;
int cc = 2 * cols + 1;
int tCells = cr * cc;
  
float centerX = (cellSize * cc) / 2;
float centerY = (cellSize * cr) / 2;

int[] cellData = new int [tCells];
int[] mazeReturn = new int [tCells];

int cell;
int frame = 0;

float camX = 0;
float camY = 0;
float camZ = 0;
float tempX = 0;
float tempY = 0;
float thisX = 0;
float thisY = 0;
float width_half;
float height_half;
float time = 0;

color boxFill;

PImage boxTexture;
PShape cellBlock;
void setup()
{
  println("starting project");
  //fullScreen(P3D);
  size(1024, 768, P3D);
  noCursor();
  width_half = width /2;
  height_half = height / 2;
  mazeReturn = generateMaze();
  
  boxTexture = loadImage("grate_t.png");
  textureMode(NORMAL);
  textureWrap(REPEAT); 
  cellBlock = createShape(BOX, cellSize);
  cellBlock.setTexture(boxTexture);
}

int getRandom(int value) {
  return floor(random(value));
}

int getExpandex(int x, int y) {
  return ((cc + 1) + (x * 2)) + ((cc * 2) * y);
}

int[] generateMaze() {
  // Blank out grid and make template room setup //
  for (int d = 0; d < tCells; d += 1) {
    int x = d % cc;
    int y = (d - x) / cc;
    int oddCell = d & 1;
    int evenRow = y % 2;
    cell = boolean(oddCell) && boolean(evenRow) ? 1 : boolean(oddCell) ? 1 : boolean(evenRow) ? 0 : 1;
    cellData[d] = cell;
  }

  for (int r = 0; r < rows; r++) {
    for (int x = 0; x < cols; x++) {
      int y = rows - r - 1;
      // test cases for cell //
      boolean canGoUp = y > 0;
      boolean canGoLeft = x < cols - 1;
      boolean coinFlip = getRandom(100) > 50;
      // get 3D cell based on flat 2D array //
      int expandex = getExpandex(x, y);
      // check and remove wall between cell //
      if ((canGoUp && !canGoLeft) || (canGoUp && coinFlip)) {
        cellData[expandex - cc] = 0;
      }
      if ((!canGoUp && canGoLeft) || (canGoLeft && !coinFlip)) {
        cellData[expandex + 1] = 0;
      }
    }
  }
  return cellData;
}

void draw()
{  
  time+=0.1; 
  background(0,0,0);
  cameraView();
  
  translate(-centerX, -centerY, 0);

  for (int d = 0; d < tCells; d += 1) {
    // get x and y from 2D position //
    int x = d % cc;
    int y = (d - x) / cc;
    // color cycling //
    //float yWave = 75 * sin((time + (x * 8)) * PI / 180);
    //float r = 255 * sin(y * 0.021 - yWave * PI / 180);
    //float g = 255 * cos(y * 0.021 + yWave * PI / 180);
    //float b = 255 * sin(y * 0.021 + yWave * PI / 180);
    //boxFill= color(r, g, b , 255);
    //boxFill= color(255,255,255,155);  
    
    if ( mazeReturn[d] == 1 ) {
      drawBox(x, y);
    } 
  }
}

void drawBox(int x, int y) {
    noStroke();
    pushMatrix();
    translate((x * cellSize), (y * cellSize), 0);
    //fill(boxFill);
    // box(cellSize, cellSize, cellSize);
    shape(cellBlock);
    popMatrix();
}

void cameraView()
{
  //tempX = random(1,255)>254 ? (width_half / 2 - random(1,width_half)) * 0.2: tempX;
  //tempY = random(1,255)>254 ? (height_half / 2- random(1,height_half)) * 0.22 : tempY;
  //camX = camX - (camX - tempX) * 0.1;
  //camY = camY - (camY - tempY) * 0.1;

  translate(width / 2, height / 2, -200);
  // rotateX(camY * PI / 180);
  rotateY((frameCount * 0.25) * PI / 180);
  rotateX(-(frameCount * 0.075) * PI / 180);
}
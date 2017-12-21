/*
 *  Binary Maze p3D Scene
 *  Paul J Karlik | pjkarlik@gmail.com
 */  

BinaryTree BinaryTree;
BinaryTree treeArray;

int cellSize = 50;
int rows = 12;
int cols = 12;
int tCells;
float centerX;
float centerY;

int[] mazeReturn = new int [tCells];

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

  treeArray = new BinaryTree(cols, rows);
  mazeReturn = treeArray.generateMaze();
  
  tCells = treeArray.cr * treeArray.cc;
  centerX = (cellSize * treeArray.cc) / 2;
  centerY = (cellSize * treeArray.cr) / 2;

  boxTexture = loadImage("grate_t.png");
  //boxTexture = loadImage("matallo.jpg");
  textureMode(NORMAL);
  textureWrap(REPEAT); 
  cellBlock = createShape(BOX, cellSize);
  cellBlock.setTexture(boxTexture);
}

void draw()
{  
  time+=0.1; 
  background(155,155,155);
  cameraView();
  
  translate(-centerX, -centerY, 0);

  for (int d = 0; d < tCells; d += 1) {
    // get x and y from 2D position //
    int x = d % treeArray.cc;
    int y = (d - x) / treeArray.cc;
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

  translate(width / 2, height / 2, -20);
  // rotateX(camY * PI / 180);
  rotateY((frameCount * 0.25) * PI / 180);
  rotateX(-(frameCount * 0.075) * PI / 180);
}
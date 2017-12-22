/*
 *  Binary Maze p3D Scene
 *  Paul J Karlik | pjkarlik@gmail.com
 */  

BinaryTree BinaryTree;
BinaryTree treeArray;

int cellSize = 150;
int rows = 17;
int cols = 17;
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
  noStroke();
  cellBlock = createShape(BOX, cellSize);
  cellBlock.setTexture(boxTexture);
}

void draw()
{  
  time+=0.1; 
  background(0,0,0);
  cameraView();
  
  translate(-centerX, -centerY, 0);

  for (int d = 0; d < tCells; d += 1) {
    // get x and y from 2D position //
    int x = d % treeArray.cc;
    int y = (d - x) / treeArray.cc;
    if ( mazeReturn[d] == 1 ) {
      drawBox(x, y);
    } 
  }
}

void drawBox(int x, int y) {
    pushMatrix();
    translate((x * cellSize), (y * cellSize), 0);
    shape(cellBlock);
    popMatrix();
}

void cameraView()
{
  
  translate(width / 2, height / 2, -20);
    
  tempX = random(1,255)>252 ? (width_half / 2 - random(1,width_half)) * 0.5: tempX;
  tempY = random(1,255)>253 ? (height_half / 2- random(1,height_half)) * 0.75 : tempY;
  camX = camX - (camX - tempX) * 0.05;
  camY = camY - (camY - tempY) * 0.05;

  rotateX(camY * PI / 180);
  rotateY(camX * PI / 180);

}
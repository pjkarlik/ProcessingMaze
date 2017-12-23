/*
 *  Binary Maze p3D Scene
 *  Paul J Karlik | pjkarlik@gmail.com
 */  

BinaryTree BinaryTree;
BinaryTree treeArray;

int cellSize = 150;
int rows = 6;
int cols = 6;
int tCells;
float centerX;
float centerY;

int[] mazeReturn = new int [tCells];
int[] position = new int[] {1, 1};
int frame = 0;

float camX = 0;
float camY = 0;
float camZ = 0;
float tempX = 0;
float tempY = 0;
float tempZ = 0;
float thisX = 0;
float thisY = 0;
float newX = 0;
float newY = 0;
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
  background(0,0,0);
  directionalLight(200, 200, 200, 0, 0.75, -0.5);
  directionalLight(170, 170, 255, -0.25, 0, 0.25);
  lightFalloff(0.5, 0, 0);
  
  time+=0.1; 

  cameraView();
  
  translate(width / 2, height / 2, 0);

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
    //float ofs = ((width_half - mouseX) * 0.05) * sin(time + (y * 25) * PI / 180) * 5;
    pushMatrix();
    translate((x * cellSize), (y * cellSize), 0);
    shape(cellBlock);
    popMatrix();
}

void cameraView()
{
  int cl = cellSize / 2;
  //translate(width / 2, height / 2, -20);
  
  int x = position[0];
  int y = position[1];

  //translate((width / 2), (height / 2), -1200);
  rotateX(90 * PI / 180);
  translate(0-(mouseX * 1.05), 0-(mouseY * 1.5), -600);
  
  //tempX = random(1,255)>252 ? (width_half / 2 - random(1,width_half)) * 0.5: tempX;
  //tempY = random(1,255)>253 ? (height_half / 2- random(1,height_half)) * 0.75 : tempY;
  //tempZ = random(1,255)>253 ? (width - random(1, width * 2)) : tempZ;
  
  //thisX = random(1,255)>252 ? (width_half / 2 - random(1,width_half)) * 0.85: thisX;
  //thisY = random(1,255)>253 ? (height_half / 2- random(1,height_half)) * 0.75 : thisY;
  
  //camX = camX - (camX - tempX) * 0.005;
  //camY = camY - (camY - tempY) * 0.005;
  //camZ = camZ - (camZ - tempZ) * 0.005;
  
  //newX = newX - (newX - thisX) * 0.01;
  //newY = newY - (newY - thisY) * 0.01;
  //translate(newX, newY, -20);
  
  //rotateY(camX * PI / 180);

}
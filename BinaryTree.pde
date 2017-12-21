/*
 *  Binary Tree Generator
 *  Paul J Karlik | pjkarlik@gmail.com
 */  

class BinaryTree {
  int rows;
  int cols;
  int cr;
  int cc;
  int tCells;
  int cell;
  int[] cellData;

  BinaryTree(int c, int r) {
    rows = r;
    cols = c;
    cr = 2 * rows + 1;
    cc = 2 * cols + 1;
    tCells = cr * cc;
    cellData = new int [tCells];
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
}
int[][] grid;
int grid_size = 25;
int grid_len = 16;

// how to colour the grid
int scale_r = 11;
int scale_g = 5;
int scale_b = 7;

public class pair {
  int first;
  int second;

  pair(int a, int b) {
    first = a;
    second = b;
  }
}

pair euc(int a, int b, int counter) {
  if (a == 0) {
    return new pair(b, counter);
  } else if (b == 0) {
    return new pair(a, counter);
  }

  if (a < b) {
    int c = a;
    a = b;
    b = c;
  }

  int c = a % b;
  if (c != 0) {
    return euc(c, b, counter + 1);
  }

  return new pair(b % a, counter + 1);
}

void init_grid() {
  grid = new int[grid_size][];

  for (int i = 0; i < grid_size; i++) {
    grid[i] = new int[grid_size];
    for (int j = 0; j < grid_size; j++) {
      int counter = 1;
      pair r = euc(abs(i - (grid_size - 1)/2), abs(j - (grid_size - 1)/2), counter);
      if (r.first == 1) {
        grid[i][j] = r.second;
      } else {
        grid[i][j] = 0;
      }
    }
  }
}

void setup() {
  size(640, 640, P2D);
  init_grid();
}

void draw() {
  background(255);
  noStroke();
  for (int i = 0; i < grid_size; i++) {
    for (int j = 0; j < grid_size; j++) {
      float fill_colour = map(grid[i][j], 0, grid_size, 255, 0);
      if (fill_colour == 255.0) {
        fill(255);
      } else {
        fill(int(scale_r * fill_colour) % 255,
             int(scale_g * fill_colour) % 255,
             int(scale_b * fill_colour) % 255);
      }
      rect(i * grid_len + 8 + i * 2, 
           j * grid_len + 8 + j * 2, 
           grid_len, 
           grid_len);
    }
  }
}

void keyPressed() {
  switch(key) {
    // colour functions
    case 'q':
      scale_r++;
      break;
    case 'Q':
      scale_r--;
      if (scale_r < 0) { scale_r = 1; }
      break;
    case 'w':
      scale_g++;
      break;
    case 'W':
      scale_g--;
      if (scale_g < 0) { scale_g = 0; }
      break;
    case 'e':
      scale_b++;
      break;
    case 'E':
      scale_b--;
      if (scale_b < 0) { scale_b = 0;}
      break;
    case 'a':
      // make grid larger
      println("a");
      grid_len++;
      break;
    case 's':
      // make grid smaller
      grid_len--;
      if (grid_len <= 0) { grid_len = 1; }
      break;
    case 'z':
      grid_size += 2;
      init_grid();
      break;
    case 'x':
      grid_size -= 2;
      if (grid_size < 3) { grid_size = 3; }
      init_grid();
      break;
    case ESC:
      exit();
  }
}
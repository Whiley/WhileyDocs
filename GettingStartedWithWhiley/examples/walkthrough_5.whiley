// A point has two integer fields named x and y
type Point is {int x, int y}

// A rectangle has a position, and a width and height
type Rectangle is {
  Point position, // position of top-left corner
  int width,      // width of the rectangle
  int height      // height of the rectangle
}
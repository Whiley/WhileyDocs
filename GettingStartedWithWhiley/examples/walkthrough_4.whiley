// A point has two integer fields named x and y
type Point is {int x, int y}

// Translate a given point by an x and y delta
function translate(Point p, int dx, int dy) -> Point:
    return { 
      x: p.x + dx, // new x value is old value plus dx
      y: p.y + dy  // new y value is old value plus dy
    }

// A point has two integer components; the first represents x, the second represents y.
type Point is (int,int)

// Translate a given point by an x and y delta
function translate(Point p, int dx, int dy) => Point:
    int x, int y = p
    return (x + dx), (y + dy)
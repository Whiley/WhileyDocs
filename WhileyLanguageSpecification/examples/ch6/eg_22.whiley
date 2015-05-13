type Point is {int x, int y}

// Translate a given point based on a delta in x and y
function move(Point p, int dx, int dy) -> Point:
    return { x: p.x+dx, y: p.y+dy }
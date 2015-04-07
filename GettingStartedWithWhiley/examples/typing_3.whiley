// Define the notion of a "rectangle"
type Rectangle is { int x, int y, int width, int height }
// Define the notion of a "bounding box"
type BoundingBox is { int x, int y, int width, int height }

// Define a function for computing the area of a rectangle
function area(Rectangle rect) -> int:
    return rect.width * rect.height
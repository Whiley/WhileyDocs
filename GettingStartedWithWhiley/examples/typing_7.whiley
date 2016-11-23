// A circle is defined by its position and radius
type Circle is { int x, int y, int radius }

// A rectangle is defined by its position and dimensions
type Rectangle is { int x, int y, int width, int height }

// A shape is either a circle or a rectangle
type Shape is Circle | Rectangle

// Determine the area of a shape
function area(Shape s) -> int:
   if s is Rectangle:
      // case for rectangle
      return s.width * s.height
   else:
      // case for circle
      return 3 * (s.radius * s.radius)

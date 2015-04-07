// A circle is defined by its position and radius
type Circle is { real x, real y, real radius }

// A rectangle is defined by its position and dimensions
type Rectangle is { real x, real y, real width, real height }

// A shape is either a circle or a rectangle
type Shape is Circle | Rectangle

// Determine the area of a shape
function area(Shape s) -> real:
   if s is Rectangle:
      // case for rectangle
      return s.width * s.height
   else:
      // case for circle
      return Math.PI * (s.radius * s.radius)

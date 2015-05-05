type IntPoint is {int x, int y}
type RealPoint is {real x, real y}

function f(IntPoint p) -> RealPoint:
    return (RealPoint) p
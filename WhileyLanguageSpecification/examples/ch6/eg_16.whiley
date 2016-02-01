type Point2D is {int x, int y}
type Point3D is {int x, int y, int z}

function f(Point3D p) -> Point2D:
    return (Point2D) p
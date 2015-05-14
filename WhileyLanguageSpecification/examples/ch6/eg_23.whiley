type Vec is {int x, int y, int z}

function dotProduct(Vec v1, Vec v2) -> Vec:
    return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z)
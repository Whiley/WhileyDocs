function max3(int x, int y, int z) => (int r)
// Return value must be as large as each parameter
ensures r >= x && r >= y && r >= z
// Return value must match at least one parameter
ensures r == x || r == y || r == z:
    //
    bool isX = x >= y && x >= z
    bool isY = y >= x && y >= z
    //
    if isX:
        return x
    else if isY:
        return y
    else:
        return z

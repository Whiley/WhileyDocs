function sum3(int x, int y, int z) => (int r)
// No parameter can be negative
requires x >= 0 && y >= 0 && z >= 0
// Return value cannot be negative
ensures r >= 0:
    //
    return x + y + z
    
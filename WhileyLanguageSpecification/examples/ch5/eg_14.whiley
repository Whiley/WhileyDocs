function abs(int x) -> (int y)
// Return value cannot be negative
ensures y >= 0:
    //
    if x >= 0:
        skip
    else:
        x = -x
    //
    return x

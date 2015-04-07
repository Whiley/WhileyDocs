function f(int x) -> (int y)
// return cannot be negative
ensures y >= 0:
    //
    int i = 0
    while i < x where i > 0:
        i = i + 1 
    //
    return i

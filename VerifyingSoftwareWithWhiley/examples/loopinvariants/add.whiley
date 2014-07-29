function add([int] xs, int x) => ([int] ret)
// Postcondition: returned list has same size as parameter
ensures |ret| == |xs|:
    //
    int i = 0
    //
    while i < |xs|:
        xs[i] = xs[i] + x
        i = i + 1
    //
    return xs

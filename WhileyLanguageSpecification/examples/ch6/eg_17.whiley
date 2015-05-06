// Determine the max of two values
function max(int x, int y) -> int:
    if x >= y:
        return x
    else:
        return y

// Determine the max of 1 or more values
function max([int] items) -> int
requires |items| > 0:
    //
    int r = 0
    nat i = 0
    while i < |items|:
        r = max(r,items[i])
        i = i + 1
    //
    return r
    
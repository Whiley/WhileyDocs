// Find first index matching x
function find(int[] xs, int x) -> int:
    int i = 0
    while i < |xs|:
        if xs[i] == x:
           break
        else:
           i = i + 1
    //
    return i
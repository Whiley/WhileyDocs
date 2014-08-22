function doubleLength([int] xs) => (int r)
// Postcondition: return value is twice length of xs
ensures r == 2 * |xs|:
    //
    int i = 0
    int r = 0
    //
    while i < |xs|:        
        i = i + 1
        r = i + i
    //
    return r
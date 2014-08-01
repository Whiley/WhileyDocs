function lastIndexOf([int] xs, int x) => (int r)
// Return value is either -1 or a valid index in xs.  
// Here, -1 indicates element was not found in list
ensures r >= -1 && r < |xs|:
// If return is not -1 then the element at that index matches
//ensures r >= 0 ==> xs[r] == x:
    //
    int i = 0
    int last = -1
    //
    while i < |xs| where i >= 0 && i <= |xs| && last >= -1 && last < i:        
        if xs[i] == x:
            last = i
        i = i + 1
    //
    return last

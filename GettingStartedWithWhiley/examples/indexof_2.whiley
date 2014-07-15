function indexOf([int] items, int item) => (int|null i)
// If return is an int r, then items[r] == item
ensures i is int ==> items[i] == item
// If return is null, then no element x in items where x == item
ensures i is null ==> no { x in items | x == item }
// If return is an int i, then no index j where j $<$ i and items[j] == item
ensures i is int ==> no { j in 0 .. i | items[j] == item }:
    //
    i = 0
    while i < |items|:
       if items[i] == item:
           return i 
       i = i + 1
    //
    return null

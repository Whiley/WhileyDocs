function indexOf(int[] items, int item) -> (int|null r)
// If return is an int r, then items[r] == item
ensures r is int ==> items[r] == item
// If return is null, then no element in items matches item
ensures r is null ==> all { j in 0..|items| | items[j] != item }
// If return is an int i, then no index j where j $<$ i and items[j] == item
ensures r is int ==> all { j in 0 .. r | items[j] != item }:
    //
    int i = 0
    while i < |items|:
       if items[i] == item:
           return i 
       i = i + 1
    //
    return null

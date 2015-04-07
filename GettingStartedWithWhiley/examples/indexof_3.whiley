
function indexOf([int] items, int item) -> (int|null r)
// If return is an int r, then items[r] == item
ensures r is int ==> items[r] == item
// If return is null, then no element x in items where x == item
//ensures r is null ==> no { x in items | x == item }
// If return is an int i, then no index j where j $<$ i and items[j] == item
ensures r is int ==> no { j in 0 .. r | items[j] == item }:
    //
    int i = 0
    while i < |items| where i >= 0 && i <= |items| && no { j in 0 .. i | items[j] == item }:
       if items[i] == item:
           return i 
       i = i + 1
    //
    return null
  
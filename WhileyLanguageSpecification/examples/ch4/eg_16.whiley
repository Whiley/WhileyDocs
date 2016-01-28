type Fun is function(int) -> int

function map(int[] items, Fun fn) -> int[]:
    //
    int i = 0
    while i < |items|:
        items[i] = fn(items[i])
        i = i + 1
    //
    return items

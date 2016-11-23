type nat is (int x) where x >= 0

function sum(nat[] items) -> nat:
    int r = 0
    int i = 0
    //
    while i < |items| where i >= 0 && r >= 0:
        r = r + items[i]
        i = i + 1
    //
    return r

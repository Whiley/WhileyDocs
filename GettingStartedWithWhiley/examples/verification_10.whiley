type nat is (int x) where x >= 0

function sum(nat[] items) -> nat:
    nat r = 0
    nat i = 0
    //
    while i < |items|:
        // ...
        r = r + items[i]
        i = i + 1
    //
    return r
        

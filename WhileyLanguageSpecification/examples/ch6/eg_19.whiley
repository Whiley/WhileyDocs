// Return first item in list over a given item
function firstOver([int] items, int item) -> int|null:
    int i = 0
    while i < |items|:
        if items[i] > item:
            return item
        i = i + 1
    // no match
    return null
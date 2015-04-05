// Return lowest index of matching item, or null if none
function indexOf([int] items, int value) -> int|null:
    int i = 0
    while i < |items|:
        if items[i] == value:
            // match
            return i
        i = i + 1
    // item not found
    return null

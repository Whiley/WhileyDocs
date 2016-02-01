function contains(int[] items, int item) -> bool:
    //
    int i = 0
    while i < |items|:
        if i == item:
            return true
        i = i + 1
    return false

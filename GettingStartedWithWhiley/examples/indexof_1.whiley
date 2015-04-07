function indexOf([int] items, int item) -> (int|null i)
// If return value is an int i, then items[i] == item
ensures i is int ==> items[i] == item:
    //
    if |items| > 0 && items[0] == item:
        return 0
    else:
        return null

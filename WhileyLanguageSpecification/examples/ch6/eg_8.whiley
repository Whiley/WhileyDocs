function rangeOf(int start, int end) -> [int]:
    [int] r = []
    int i = start
    while i < end:
        r = r ++ [i]
        i = i + 1
    return r

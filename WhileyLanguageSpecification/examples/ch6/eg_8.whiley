function cons(int head, [int] tail) -> [int]:
    [int] r = [head; |tail| + 1]
    int i = 0
    //
    while i < |tail|:
        r[i+1] = tail[i]
        i = i + 1
    //
    return r

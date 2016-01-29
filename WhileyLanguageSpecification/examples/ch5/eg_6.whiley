function sumNonNegative(int[] xs) -> int:
    int i = 0
    int r = 0
    while i < |xs|:
        if xs[i] < 0:
            continue
        r = r + xs[i]
        i = i + 1
    return r

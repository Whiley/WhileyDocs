function indexOf(int[] xs, int i) -> int
requires i >= 0 && |xs| > 0:
    //
    return xs[i % |xs|]

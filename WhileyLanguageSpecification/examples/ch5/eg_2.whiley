function abs(int x) -> int:
    if x < 0:
        x = -x
    assert x >= 0
    return x

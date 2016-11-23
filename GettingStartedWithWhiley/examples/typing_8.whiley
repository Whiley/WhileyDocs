function toInteger(any x) -> int:
    if x is int:
        return x
    else if x is any[]:
        return |x|
    else:
        return 0 // default value

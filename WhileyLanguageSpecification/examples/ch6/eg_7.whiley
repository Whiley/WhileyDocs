function containsOne({int} xs, {int} ys) -> bool:
    for x in xs:
        if x in ys:
            return true
    return false

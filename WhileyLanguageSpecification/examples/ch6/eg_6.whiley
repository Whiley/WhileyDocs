function compare({int} xs, {int} ys) -> int:
    if xs $\subset$ ys:
        return -1
    else if ys $\subset$ xs:
        return 2
    else if xs == ys:
        return 1
    else:
        return 0

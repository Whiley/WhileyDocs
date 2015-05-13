// Recursively compute the sum of a list
function sum([int] items) -> int:
    if |items| == 0:
        return 0
    else:
        return items[0] + sum(items[1..|items|])
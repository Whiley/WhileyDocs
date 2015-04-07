function f(int x) -> (int y)
// Return cannot be negative
ensures y >= 0:
    //
    return x

function g() -> (int y)
// Return cannot be negative
ensures y >= 0:
    //
    return f(1)

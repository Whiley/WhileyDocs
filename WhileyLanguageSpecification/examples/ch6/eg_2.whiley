function implies(bool x, bool y) -> bool:
    return !x || y

function iff(bool x, bool y) -> bool:
    return implies(x,y) && implies(y,x)

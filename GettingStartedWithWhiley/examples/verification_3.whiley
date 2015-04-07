type nat is (int n) where n >= 0
type pos is (int p) where p > 0

function f(pos x) -> (nat n)
// Return must differ from parameter
ensures n != x:
    //
    return x-1


function diff(int x, int y) => (int r)
// x is between 0 and 10
requires 0 <= x && x <= 10
// y is between 1 and 5
requires 1 <= y && y <= 5
// constraint return value
ensures 0 <= r && r <= 9:
    //
    if x > y:
        return x - y
    else:
        return y - x
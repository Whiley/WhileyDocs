constant digits is ['0','1','2','3','4','5','6','7','8','9']

// Convert an integer value into a string
function toString(int item) -> int[]:
    int[] r = [0;0]
    //
    while item != 0:
        int v = item / 10
        int w = item % 10
        r = Arrays.append(digits[w],r)
        item = v
    //
    return r

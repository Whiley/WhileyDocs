// Check whether an array is sorted or not
function isSorted(int[] items) -> bool:
    int i = 1
    //
    while i < |items|:
        if items[i-1] > items[i]:
            return false
        i = i + 1
    //
    return true

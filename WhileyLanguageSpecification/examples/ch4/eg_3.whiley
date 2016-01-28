// Determine whether item is contained in list or not
function contains(int[] list, int item) -> bool:
    // examine every element of list
    int i = 0
    while i < |list|:
        if list[i] == item:
            return true
        i = i + 1
    // done
    return false

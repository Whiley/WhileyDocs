type LinkedList is null | &{LinkedList next, int data}

method length(LinkedList l) -> int:
    //
    if l is null:
        return 0
    else:
        return 1 + length((*l).next)

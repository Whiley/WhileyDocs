function sum(LinkedList l) => int:
    if l is null:
        return 0
    else:
        return l.data + sum(l.next)

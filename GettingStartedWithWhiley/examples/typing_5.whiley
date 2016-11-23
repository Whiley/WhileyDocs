type Link is {int data, LinkedList next}
type LinkedList is null | Link
type OrderedList is null | { int data, int order, OrderedList next }

function sum(LinkedList l) -> int:
    if l is null:
        return 0
    else:
        return l.data + sum(l.next)

function sum(OrderedList l) -> int:
    return sum((LinkedList) l)

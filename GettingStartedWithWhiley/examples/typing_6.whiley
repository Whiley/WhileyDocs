type Link is {int data, LinkedList next}
type LinkedList is null | Link
type OrderedList is null | { int data, int order, OrderedList next }
function sum(OrderedList l) => int:
    return sum((LinkedList) l)
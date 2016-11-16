// Define the well-known concept of a linked list
type LinkedList is null | &{ LinkedList next, int data }

// Define a method which inserts a new item onto the end of the list
method insertAfter(LinkedList list, int item) -> LinkedList:
    if list is null:
        // reached the end of the list, so allocate new node
        return new { next: (LinkedList) null, data: item }
    else:
        // continue traversing the list
        list->next = insertAfter(list->next, item)
        return list

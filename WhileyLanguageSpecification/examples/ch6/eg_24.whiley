type LinkedList is null | &{LinkedList next, int data}

// Add a new item onto the head of the list
method add(LinkedList list, int item) -> LinkedList:
    //
    return new {next: list, data: item}
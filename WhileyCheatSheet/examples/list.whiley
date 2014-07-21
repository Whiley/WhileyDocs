// A linked list is either the empty list or a link
type LinkedList is null | Link

// A single link in a linked list
type Link is {int data, LinkedList next}

// Return length of linked list (i.e. number of links it contains)
function length(LinkedList l) => int:
  if l is null:    
     // l now has type null
    return 0
  else:    
    // l now has type \{int data, LinkedList next\}
    return 1 + length(l.next)

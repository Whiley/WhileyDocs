// A linked list is either the empty list or a link
type LinkedList is EmptyList | Link

// The empty list contains no links
type EmptyList is null

// A single link in a linked list
type Link is {int data, LinkedList next}

// Return the length of a linked list (i.e. the number of links it contains)
function length(LinkedList l) => int:
  if l is null:    
    return 0 // l now has type null
  else:    
    return 1 + length(l.next) // l now has type {int data, LinkedList next}
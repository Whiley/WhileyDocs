type ListOfNats is ([int] items)
// does not exist an x in items where is less-than zero
where !some { x in items | x < 0 }

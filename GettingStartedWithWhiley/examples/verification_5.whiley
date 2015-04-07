type ListOfNats is ([int] items)
// every x in items must be greater-or-equal-to zero
where all { x in items | x >= 0 }

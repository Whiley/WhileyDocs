type ListOfNats is ([int] items)
// no x in items is less-than zero
where no { x in items | x < 0 }

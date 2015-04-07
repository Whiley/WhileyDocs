function indexOf([int] items, int item) -> null|int:
   int i = 0
   while i < |items|:
      if items[i] == item:
         return i
      i = i + 1
   return null

function split([int] items, int item) -> [[int]]:
   int|null idx = indexOf(items,item)
   // idx has type null$|$int
   if idx is int:
       // idx now has type int
       [int] below = items[0..idx]
       [int] above = items[idx..]
       return [below,above]
   else:
       // idx now has type null
       return [items] // no occurrence
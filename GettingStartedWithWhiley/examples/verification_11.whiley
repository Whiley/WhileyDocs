function create(int count, int value) -> ([int] r)
// Cannot create negatively sized lists!
requires count >= 0
// Returned list must have count elements
ensures |r| == count:
   //
   int i = 0
   [int] r = []
   while i < count:
      r = r ++ [value]
      i = i + 1
   //
   return r

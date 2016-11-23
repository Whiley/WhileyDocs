function fill(int[] items, int start, int value) -> (int[] r)
// Cannot start from negative index!
requires start >= 0
// Returned array must have same number of elements
ensures |r| == |items|:
   //
   int i = start
   while i < |items|:
      items[i] = value
      i = i + 1
   //
   return items

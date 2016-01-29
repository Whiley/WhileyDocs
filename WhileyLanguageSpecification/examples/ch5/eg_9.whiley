import whiley.lang.Math

function max(int[] items) -> int
// Input list cannot be empty
requires |items| > 0:
   //
   int r = items[0]
   int i = 0
   //
   while i < |items|:
      r = Math.max(r,items[i])
      i = i + 1
   
   return r

function max([int] items) -> int
// Input list cannot be empty
requires |items| > 0:
   //
   int r = items[0]
   
   for v in items:
        r = Math.max(r,v)
   
   return r

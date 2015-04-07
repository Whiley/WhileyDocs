function reverse([int] xs) -> ([int] ys)
// size of lists are the same
ensures |xs| == |ys|:
   int i = 0
   [int] zs = xs
   //
   while i<|xs| where i>=0 && |xs|==|zs|:
       int j = |xs| - (i+1)
       xs[i] = zs[j]
       i = i + 1
   return xs

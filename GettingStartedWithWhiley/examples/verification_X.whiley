function reverse([int] xs) -> ([int] ys)
// size of lists are the same
ensures |xs| == |ys|
// 
ensures all { i in 0..|xs| | xs[i] == ys[i] }:
   //
   int i = 0
   [int] zs = xs
   //
   while i < |xs| where i >= 0 && |xs| == |zs|:
       int j = |xs| - (i+1)
       xs[i] = zs[j]
   //
   return xs

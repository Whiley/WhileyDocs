// Rotate head item to back of list
function reverse([int] xs) -> ([int] ys)
// Permutation does not change sum
ensures |xs| > 0 ==> sum(xs) == sum(ys):
   //
   int i = 0
   [int] zs = xs
   //
   while i < |xs| where i >= 0 && |xs| == |zs|:
       int j = |xs| - (i+1)
       xs[i] = zs[j]
   return xs

function sum([int] xs) -> (int r)
requires |xs| > 0
// Base case: list of size 1
ensures |xs| == 1 ==> r == xs[0] 
// General case: list of size greater than 1
ensures |xs| > 1 ==> r == xs[0] + sum(xs[1..]):
   // ...
   return 0


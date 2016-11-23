// Rotate head item to back of array
function reverse(int[] xs) -> (int[] ys)
// Permutation does not change sum
ensures |xs| > 0 ==> sum(xs,0) == sum(ys,0):
   //
   int i = 0
   int[] zs = xs
   //
   while i < |xs| where i >= 0 && |xs| == |zs|:
       int j = |xs| - (i+1)
       xs[i] = zs[j]
   return xs

function sum(int[] xs, int start) -> (int r)
requires |xs| > 0 && start >= 0 && start <= |xs|
// Base case: array of size 1
ensures |xs| == 1 ==> r == xs[0] 
// General case: array of size greater than 1
ensures |xs| > 1 ==> r == xs[0] + sum(xs,start+1):
   // ...
   return 0

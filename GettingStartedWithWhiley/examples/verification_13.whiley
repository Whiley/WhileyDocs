function sum(int[] xs, int start) -> (int r)
requires |xs| > 0 && start >= 0 && start <= |xs|
// Base case: array of size 1
ensures |xs| == 1 ==> r == xs[0] 
// General case: array of size greater than 1
ensures |xs| > 1 ==> r == xs[0] + sum(xs,start+1):
   // ...
   return 0

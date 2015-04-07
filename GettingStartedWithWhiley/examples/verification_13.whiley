function sum([int] xs) -> (int r)
requires |xs| > 0
// Base case: list of size 1
ensures |xs| == 1 ==> r == xs[0] 
// General case: list of size greater than 1
ensures |xs| > 1 ==> r == xs[0] + sum(xs[1..]):
   // ...
   return 0

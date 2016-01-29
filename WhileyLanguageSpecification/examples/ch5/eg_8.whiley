function sum(int[] xs) -> int
// Input must not be empty list
requires |xs| > 0:
  //
  int r = 0
  int i = 0
  do:
    r = r + xs[i]
    i = i + 1
  while i < |xs| where i >= 0
  //
  return r

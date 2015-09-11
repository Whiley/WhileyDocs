// Find index of matching element, or return -1
function indexOf(int[] xs, int x) -> int:
  int i = 0
  //
  while i < |xs| where i >= 0:
     if xs[i] == x:
        return i         
     i = i + 1
  return -1

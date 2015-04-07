// Remove lowest element holding x from xs
function remove([int] xs, int x) -> [int]:
  int i = 0
  while i < |xs| where i >= 0:
     if xs[i] == x:
        break
     else:
        i = i + 1
  return xs[0..i] ++ xs[i+1..]

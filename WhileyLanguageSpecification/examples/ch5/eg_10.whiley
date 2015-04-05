type nat is (int x) where x >= 0
type neg is (int x) where x < 0

function f(int|null x) -> bool|null:
  //
  if x is nat:
     return true
  else if x is neg:
     return false
  else:
     fail

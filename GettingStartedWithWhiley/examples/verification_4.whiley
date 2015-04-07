 type anat is (int x) where x >= 0
 type bnat is (int x) where 2*x >= x

 function f(anat x) -> bnat:
     return x

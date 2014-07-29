// Arrays_Insertion_Sort.dfy

//********************************************************************************
//                          Part A
//********************************************************************************

predicate sorted_between(a: array<int>, from:int, to:int)
	requires a!= null; reads a;
{  
	forall i,j :: from<=i<j<to && 0<=i<j<a.Length ==> a[i]<=a[j]
}

predicate sorted(a: array<int>)
	requires a!= null; reads a;
{  
	sorted_between(a,0,a.Length) 
}

 
//********************************************************************************
//                          Part B
//********************************************************************************
 
function count<T>(x: T, s: seq<T>): nat
{
  if (|s| == 0)
  then 0
  else
    if x == s[0]
    then 1 + count(x, s[1..])
    else count(x, s[1..])
}

ghost method prop_count_add<T>(x: T, s: seq<T>, t: seq<T>)
  ensures count(x,s+t) == count(x,s)+count(x,t);
 { 
   if (|s| == 0)
      { calc{ count(x,s+t);
            == { assert s+t==t; }
          count(x,t);
          ==
         0 + count(x,t);
          ==
         count(x,s)+count(x,t);   }         
      } 
  else if (x==s[0])
        {calc {count(x,s+t);
            ==  
            1 + count(x,(s+t)[1..]);
            == { assert (s+t)[1..] == s[1..]+t; }
            1 + count(x,s[1..]+t);
            ==
            1 + count(x,s[1..]) + count(x,t);
            ==
            count(x,s)+count(x,t);  } }
  else 
     { calc { count(x,s+t);
            ==  
             0 + count(x,(s+t)[1..]);
            == { assert (s+t)[1..] == s[1..]+t; }
            0 + count(x,s[1..]+t);
            ==
            0 + count(x,s[1..]) + count(x,t);
            ==
            count(x,s)+count(x,t);   } }
    /* var i := if (x==s[0]) then 1 else 0;
      calc{ count(x,s+t);
            ==  
            i + count(x,s[1..]+t);
            ==
            i + count(x,s[1..]) + count(x,t);
            ==
            count(x,s)+count(x,t);   } } */
 }
  
  
predicate perm<T>(a: seq<T>, b: seq<T>) 
{
  forall x :: count(x, a) == count(x, b)
}

predicate perm_except<T>(a: seq<T>, b: seq<T>, j:nat, temp: T) 
   requires 0<=j<|a|  ;
{
  perm(a[0..j]+[temp]+a[j+1..], b)
}

      
// *****************************************************************************
//                            Part C  
//******************************************************************************

method InsertionSorta(a: array<int>)
  requires a != null;
  modifies a;
  ensures sorted(a) && perm(a[..], old(a[..]) );
{
  var i := 1;
   
  while (i < a.Length)
    invariant ???
    invariant ????
  {
    var temp := a[i]; 
    var j := i;
    while (j > 0 && temp <= a[j - 1])
        invariant ????
    {   a[j] := a[j - 1];
        j := j - 1;
    }	
    a[j] := temp;   
    i := i + 1;
  }
}
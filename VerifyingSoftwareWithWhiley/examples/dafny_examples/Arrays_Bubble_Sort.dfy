// ************************************************************************************
//                       Arrays_Bubble_Sort.dfy
// ************************************************************************************

// ************************************************************************************
//                      Step 1, preliminaries
// ************************************************************************************ 
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

ghost method LemmaOne(a: array<int>, from:int, to:int, m:nat, n:nat)
	requires a!= null; 
	ensures sorted_between(a,from,to) ==> sorted_between(a,from+m,to-n);
 { }

 ghost method LemmaTwo(a: array<int>, from:int, to:int, m:nat, n:nat)
	requires a!= null && from<=0 && to>=a.Length;
	ensures sorted_between(a,from,to) ==> sorted_between(a,from-m,to+n);
 { }


function count<T>(x: T, s: seq<T>): nat
{
  if (|s| == 0)
  then 0
  else
    if x == s[0]
    then 1 + count(x, s[1..])
    else count(x, s[1..])
}

predicate perm<T>(a: seq<T>, b: seq<T>) 
{
  forall t :: count(t, a) == count(t, b)
}

 


predicate same<T>(a:seq<T>, b:seq<T>)
     { |a|==|b| && ( forall k:: 0<=k<|a| ==> a[k]==b[k] ) }
     
ghost method same_implies_perm<T>(a: seq<T>, b: seq<T>) 
   requires same(a,b);
   ensures perm(a,b);
 {  if |a|==0   {}  else { same_implies_perm(a[1..],b[1..]);}  }
 
 ghost method perm_trans<T>(a: seq<T>, b: seq<T>, c: seq<T>) 
   requires perm(a,b) && perm(b,c);
   ensures perm(a,c);
 {     }
     
// ************************************************************************************
//                      Step 2, secify bubble sort
// ************************************************************************************ 

method bubbleSorta(a: array<int>)
	requires a!= null;
	modifies a;
	ensures sorted(a) && perm(a[..],old(a[..]));

// ************************************************************************************
//                      Step 3, sketching method bosy for bubble sort
// ************************************************************************************ 

method bubbleSortb(a: array<int>)
	requires a!= null;
	modifies a;
	ensures sorted(a) && perm(a[..],old(a[..]));
{
    var i : nat := 0;

	while(i < a.Length)
		invariant 0<=i<=a.Length;
		invariant sorted_between(a,0,i); 
		decreases a.Length-i;
    {   i := i+1;
	    assume sorted_between(a,0,i) && perm(a[..],old(a[..]));
	}
}

// ************************************************************************************
//                      Step 4, introducing an auxiliary method
// ************************************************************************************ 
 
 method bubbleSortc(a: array<int>)
	requires a!= null && a.Length>0;
	modifies a;
	ensures perm(old(a[..]),a[..]) && sorted(a);
{
	var i : nat := 1;
	assert sorted_between(a,0,i);

	while(i < a.Length)
    		invariant 0<i<=a.Length;
  	    invariant  perm(old(a[..]),a[..]) && sorted_between(a,0,i); 
    		decreases a.Length-i;
       {   ghost var a_before := a[..];
           assert perm(old(a[..]),a_before);
           pushToRight(a,i);
           ghost var a_after := a[..];
           perm_trans(old(a[..]),a_before,a_after);
	         i := i+1;
	      }
	assert sorted_between(a,0,a.Length);
}
 
// ************************************************************************************
//                      Step 5 & Step 6 body for pushToRight and of swap
// ************************************************************************************ 
 
 
method pushToRight(a: array<int>, i: nat)
   // pushes a[i] to the right as long as it is smaller than
   // the elements to its right
   requires a!=null && 0<i<a.Length && sorted_between(a,0,i);
   modifies a;
   ensures  perm(old(a[..]),a[..]) && sorted_between(a,0,i+1);  
{  var j : nat := i;

 	while(j>0 && a[j-1]>a[j])
		invariant 0<=j<=i;
		invariant perm(old(a[..]),a[..]) && sorted_between(a,0,j) && sorted_between(a,j,i+1);
		invariant forall k,k':: 0<=k<j && j+1<=k'<i+1 ==> a[k]<=a[k'];
//		decreases j;   // decreases caluse not necessaty
    {  
	    ghost var a_before := a[..];
      
 		swap(a,j-1,j);

    //  assert swapped(a_before,a[..],j-1,j);
        swap_implies_perm(a_before,a[..],j-1,j);
 

        j:=j-1;
	}

}

method swap<T>(a: array<T>, i: nat, j:nat)
   // swaps a[i] and a[j] in the wrray a
   requires a!=null && 0<=i<a.Length &&  0<=j<a.Length ;
   modifies a;
   ensures  swapped(old(a[..]),a[..],i,j); 
{
	   var temp : T := a[i];  a[i]:=a[j];  a[j]:=temp; 
}

predicate swapped<T>(a:seq<T>, b:seq<T>, i: nat, j:nat)
    requires |a|==|b| && 0<=i<|a| && 0<=j<|a|;
{ ( forall k:: 0<=k<|a| &&  k!=i && k!=j ==> a[k]==b[k] )
		&&
  ( b[j]==a[i] )
		&&
  ( b[i]==a[j] )  }


ghost method swap_implies_perm<T>(a:seq<T>, b:seq<T>, i: nat, j:nat)
     requires|a|==|b| && 0<=i<|a| && 0<=j<|a| && swapped(a,b,i,j);
     ensures perm(a,b);


// ************************************************************************************
//                      Step 7, inlie expand all method bodies
// ************************************************************************************ 

method bubbleSortd(a: array<int>)
// now we inline the function pushToRight 
	requires a!= null && a.Length>0;
	modifies a;
	ensures perm(a[..],old(a[..])) && sorted(a);
{
	var i : nat := 1;
	
	while(i < a.Length)
		invariant 0<i<=a.Length;
	    invariant  perm(a[..],old(a[..])) && sorted_between(a,0,i); 
		decreases a.Length-i;
	{   var j : nat := i;

		while(j>0 && a[j-1]>a[j])
			invariant 0<=j<=i;
			invariant perm(a[..],old(a[..])) && sorted_between(a,0,j) && sorted_between(a,j,i+1);
			invariant forall k,k':: 0<=k<j && j+1<=k'<i+1 ==> a[k]<=a[k'];
			//decreases j;
		{	ghost var a_before := a[..];
      
             var temp : int := a[j-1];  a[j-1]:=a[j];  a[j]:=temp; 
	         ghost var a_after := a[..];
      
             swap_implies_perm(a_before,a_after,j-1,j);
             j:=j-1;
		}

		i := i+1;
	}


}




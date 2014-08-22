// ****************************************************************************************
//                               Max_Product.dfy
// ****************************************************************************************

//
// ******************************  Question 1 **************************************
//  
method max(a: array<int>) returns (max: nat)
  requires a != null && a.Length > 0;
  requires forall j:: 0<=j<a.Length ==> a[j] >= 0;
  ensures forall j:: 0<=j<a.Length ==> a[j] <= max;
  ensures exists j:: 0<=j<a.Length && a[j]==max;
{
  max := 0;
  var i := 0;

  while (i < a.Length)
    invariant 0 <= i <= a.Length;
    invariant forall j:: 0<=j<i ==> a[j] <= max;
    invariant i!=0 ==> exists j:: 0<=j<i && a[j]==max;
    invariant i==0 ==> a[0] >= max;
{
 	if (a[i] > max) {
	  max := a[i]; 
    }
     i := i + 1;
  }
}

//
// ******************************  Question 2 **************************************
// 
function product(a: array<int>): int
    requires a!=null;
	reads a;
{
  productAux(a,0,a.Length-1) 
}

function productAux(a: array<int>, from:nat, to:int): int
	requires a!=null && to < a.Length; 
	reads a;
	decreases to-from;
{
  if ( from > to )
	then 1
  else if ( from==to )
	then a[to] 
	else productAux(a,from,to-1) * a[to] 
}

function productAuxAlt(a: array<int>, from:nat, to:int): int
	requires a!=null && to < a.Length; 
	reads a;
 	decreases to-from;
{
  if ( from > to )
	then 1
  else if ( from==to )
	then a[to] 
	else a[from] * productAuxAlt(a,from+1,to)   
}

ghost method Lemma(a: array<int>, from:nat, to:int)
   requires a!=null && to < a.Length;
   ensures productAux(a,from,to) == productAuxAlt(a,from,to);
   decreases to-from;
 { if (from>to)  {   }
   else { if (from==to) { }
          else {assume false; } }
 }

method Product(a: array<int>)
  returns (p: int)
  requires a != null;
  ensures p == product(a);
{
  var i := 0;
  p := 1;

  while (i < a.Length)
		invariant 0 <= i <= a.Length;
		invariant p == productAux(a,0,i-1);
  {
		p := p * a[i];
		i := i + 1;
  }

}

//
// ******************************  Question 3 **************************************
// 

method ProductAlt(a: array<int>) returns (p: int)
  requires a != null;
  ensures p == product(a);
{
  var i := a.Length-1;
  p := 1;

  while (i >= 0)
		    invariant -1 <= i <= a.Length;
			invariant p == productAuxAlt(a,i+1,a.Length-1);
  {
		p := p * a[i];
		i := i - 1;
  }
  // notice that we call the lemma here
  Lemma(a,0,a.Length-1);
}

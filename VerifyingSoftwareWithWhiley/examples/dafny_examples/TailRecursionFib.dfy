//
// TailRecursionFib.dfy
//
function fib(n: nat): nat
{
  if n < 2 then
    n
  else  
    fib(n-1)+fib(n-2)
}
 
function F(n: nat, k: nat, m1: nat, m2: nat): nat
  requires n >= k;
  decreases n - k;
{
  if n == k then
    m1+m2
  else
    F(n, k + 1, m1 + m2, m1)
}

function G(n: nat): nat
{
    if n<2 then n
	else  F(n,2,1,0)
}

ghost method Lemma(n: nat)
       ensures fib(n) == G(n); 
{  if n<2  
     { } 
   else 
     { AuxLemma(n,2,1,0); }
}


// They key of the argument, is in the AuxLemma. Obviously,
// what we need is that  
//          forall n:: n>=2 ==> fib(n)==F(n,2,1,0);
// However, the assertion from above is too special, and\
// cannot be proven inductively.
// We need to think of the _reason_ why F cacluates fib,
// and of the relation between the arguments of F
// Namely, F(_,k,m1,m2) is always called so that
// m1==fib(k-1) and m2==fib(k-2). Moreover, in every
// call of F(n,k,_,_) we have that 2<=k<=n.
// The following auxiliary lemma expresses these things:

ghost method AuxLemma(n:nat,k:nat,m1:nat,m2:nat)
	requires 2<=k<=n && m1==fib(k-1) && m2==fib(k-2);
	ensures fib(n)==F(n,k,m1,m2);
	decreases n-k;
{ 
  if n==k 
     { }  
  else 
     {  AuxLemma(n,k+1,m1+m2,m1);   }
}
 
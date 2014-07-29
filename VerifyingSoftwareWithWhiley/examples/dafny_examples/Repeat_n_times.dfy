// 
// Repeat_n_times.dfy
//

type T;
function f(t: T): T
 
function F(x: T, n: nat): T
{
  if n == 0 then x else F(f(x), n-1)
}
 
function G(x: T, n: nat): T
{
  if n == 0 then x else f(G(x, n-1))
}
 
// *****************************************************
//           First Version of the Proof
// *****************************************************
 
 
 ghost method LemmaAlt(x: T, n: nat)
// This is an alternative proof
// which does not use auxiliary lemmas
// Note that it uses the inductive hypothesis 3 times
// in a different manner each
  ensures F(x, n) == G(x, n);
{
  
     if n==0   {  }
     else {
       if n==1 {  }
       else {
        calc{
			F(x,n); 
				== // by definition  of F
			F(f(x), n-1);
				==  { LemmaAlt(f(x),n-1); }  
			G( f(x), n-1);
				== // by definition of G
			f( G(f(x), n-2 ));
				== { LemmaAlt(f(x),n-2); }
			f( F(f(x), n-2) );
				== // by definition of F
			f( F(x, n-1) );
				== { LemmaAlt(x,n-1); }   
			f( G(x, n-1) );
				==
                G(x,n);
         }  
     }  
} }

ghost method LemmaAltShort(x: T, n: nat)
// This is the same as LemmaAlt
// written in its most succint form
  ensures F(x, n) == G(x, n);
{
  
     if n<2 { } 
     else {  LemmaAltShort(f(x),n-1); 
		  LemmaAltShort(f(x),n-2);  
         }  
}  

// *****************************************************
//           Second Version of the Proof
// *****************************************************

 // This proof uses two auxiliary lemmas. 
ghost method Lemma(x: T, n: nat)
  ensures F(x, n) == G(x, n);
{
  
     if n==0   {  }
     else if n==1 {  }
     else {
        calc{
           F(x,n); 
				==
           F(f(x), n-1);
				== { Aux1(f(x),n-1); }
           f(F(f(x), n-2));
				==  { Lemma( f(x), n-2) ; 
                          // assert F(f(x), n-2) 
                          // == G(f(x),n-2);
				     }
           f(G(f(x),n-2));
				== { Aux2(x,n-1); }
           f(G(x,n-1)) ;
				 ==
           G(x,n);
         }  
} }


ghost method Aux1(x:T, n: nat)
   requires n>0;
   ensures F(x,n) ==f(F(x,n-1));
   // case analysis needed; Dafny cannot prove automatically
{   if n ==0 {}  
    else if (n==1){   }
    else
       { 
         calc{
		 // calc is needed; Dafny cannot do it without
             F(x,n);
             ==
             F(f(x),n-1);
             ==  {  Aux1(f(x), n-1); }
             f(F(f(x),n-2));
             ==
             f(F(x,n-1));       
          }  }
}  

  
ghost method Aux2(x:T, n: nat)
   requires n>0;
   ensures G(x,n) ==G(f(x), n-1);
 {    } 
function P(i: nat, j: nat ) : nat
     requires j<=i;
{ if j==0 || i==j then 1 else P(i-1,j-1)+P(i-1,j)  }

ghost method LemmaSym(i: nat, j: nat )
     requires j<=i;
     ensures P(i,j)==P(i,i-j);
     
method CalcP(i: nat, j: nat ) returns (res:nat)
     requires j<=i;
{ if (j==0 || i==j) 
  { res:= 1; }
 else 
     { var res1 := CalcP(i-1,j-1);
       var res2 := CalcP(i-1,j);
       res:= res1 + res2;
     }      
}
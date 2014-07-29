// Question 1: GCD   Imperative_SA.dfy

function gcd(m: nat, n: nat): nat
  requires m>=1;
  requires n>=1;
  decreases m+n;
{ 
  if (n==m) then n 
  else if (m>n) then gcd (m-n,n) 
  else gcd(m,n-m) 
}

method GcdCal(m: nat, n: nat) returns (res: nat)
  requires m>=1;
  requires n>=1;
  ensures res == gcd(m, n);
{ 
  var m1: nat, n1: nat := m, n;

  while (m1!=n1) 
    invariant m1>=1;
    invariant n1>=1;
    invariant gcd(m, n)==gcd(m1, n1);
    decreases m1+n1;
  {  
    if (m1>n1) { 
      m1 := m1-n1; 
    } 
    else { 
      n1 := n1-m1;  
    }
 }
 return m1;
}


// Question 2: Product (double nested)

method CalcProduct(m: nat, n: nat) returns (res: nat)
  ensures res == m*n;
{ 
  var m1: nat := m;
  res := 0;
  
  while (m1!=0) 
     invariant res == (m-m1)*n;
     decreases m1;
  {   
    var n1: nat := n;
    while (n1!=0)
      invariant res == (m-m1)*n + (n-n1);
      decreases n1;
    {    
      res := res+1;
      n1 := n1-1; 
    }  
    m1 := m1-1;
  }
}

// Question 2a: Product (triply nested)

method CalcThreeProduct(m: nat, n: nat, p: nat) 
  returns (res: nat)
  ensures res == m*n*p;
{ 
  var m1: nat := 0;
  res := 0;
  
  while (m1!=m) 
    invariant m1<= m;
    invariant res == m1*n*p;
    decreases (m-m1);
  {   
    var n1: nat := 0;
    while (n1!=n)
      invariant n1<=n;
      invariant res == m1*n*p + n1*p ;
      decreases (n-n1);
    {   
      var p1: nat := 0; 
      while (p1!=p)
        invariant p1<=p;
        invariant res == (m1)*n*p + (n1)*p + p1;
        decreases (p-p1);
      {   
        res := res+1;
        p1 := p1+1; 
      }
      n1 := n1+1;
    } 
    m1:= m1+1;
  }
}

// Question 3: 3*n-2*n (consecutive loops)
function method abs(m: int): nat
{ if m>0 then m else -m }

method CalcTerm(m: int, n: nat) returns (res: int)
  ensures res==3*m-2*n;
{ 
  var m1: nat := abs(m);
  var n1: nat := n;
  res := 0;
  
  while (m1!=0)
    invariant res == (abs(m)-abs(m1))*3;
    decreases m1;
  { 
    res := res+3; 
    m1 := m1-1;
  }

  if (m<0) { res := -res; }
  
  while (n1!=0)
    invariant res == 3*m - (n-n1)*2;
    decreases n1;
  {
    res := res-2; 
    n1 := n1-1;
  }
}

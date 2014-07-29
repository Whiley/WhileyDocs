
// TailRecursionSimpler.dfy

function f(n: nat): nat
{
  if n == 0 then
    9
  else if n == 1 then
    7
  else if n == 2 then
    5
  else
    f(n - 1) + f(n - 3)
}

ghost method L1()
  ensures f(1) == 7;

ghost method L2()
  ensures f(2) == 5;

ghost method L0()
  ensures f(0) == 9;

function F(n: nat, k: nat, m1: nat, m2: nat, m3: nat): nat
  requires n >= k;
  decreases n - k;
{
  if n == k then
    m1
  else
    F(n, k + 1, m1 + m3, m1, m2)
}

function G(n: nat): nat
{
  if n == 0 then
    9
  else if n == 1 then
    7
  else if n == 2 then
    5
  else
    F(n, 2, 5, 7, 9)
}

ghost method Lemma(n: nat)
  ensures f(n) == G(n);
{
  if n == 0 {
    assert f(n) == G(n);
  } else {
    if n == 1 {
      assert f(n) == G(n);
    } else {
      if n == 2 {
        assert f(n) == G(n);
      } else {
        L2();
        L1();
        L0();
        assert 2 <= n && 5 == f(2) && 7 == f(1) && 9 == f(0);
        AuxLemma2(n, 2, 5, 7, 9);
        assert f(n) == G(n);
      }
    }
  }
}

ghost method {:induction false} AuxLemma2(n: nat, k: nat, m1: nat, m2: nat, m3: nat)
  requires 2 <= k <= n && m1 == f(k) && m2 == f(k - 1) && m3 == f(k - 2);
  ensures f(n) == F(n, k, m1, m2, m3);
  decreases n - k;
{
  if n == k {
  } else {
    calc {
      f(n);
			== { AuxLemma2(n, k + 1, m1 + m3, m1, m2); }
      F(n, k + 1, m1 + m3, m1, m2);
			==
	  F(n, k, m1, m2, m3);
    }
  }
}

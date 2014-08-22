// Change.dfy

datatype list<T> = Nil | Cons(T, list<T>);

predicate elem<T>(n: T, xs: list<T>)
{
  match xs
  case Nil =>
    false
  case Cons(y, ys) =>
    n == y || elem(n, ys)
}

function sum(vals: list<int>): int
{
  match vals
  case Nil =>
    0
  case Cons(v, vs) =>
    v + sum(vs)
}

function repeat<T>(x: T, n: nat): list
{
  if n == 0 then
    Nil
  else
    Cons(x, repeat(x, n - 1))
}

function len(xs: list): nat
{
  match xs
  case Nil =>
    0
  case Cons(_, ys) =>
    1 + len(ys)
}

predicate subset(xs: list, ys: list)
{
  forall x :: 
    elem(x, xs) ==>
      elem(x, ys)
}

predicate subsequence(xs: list, ys: list)
{
  match xs
  case Nil =>
    true
  case Cons(x, xs') =>
    match ys
    case Nil =>
      false
    case Cons(y, ys') =>
      if x == y then
        subsequence(xs', ys')
      else
        subsequence(xs, ys')
}

predicate all_nat(units: list<int>)
 { forall x:: elem(x,units) ==> x>=0 }

predicate correct_change(units: list<int>, amount: nat, change: list<int>)
{
  all_nat(units) && subset(change, units) &&
  sum(change) == amount
}

predicate change_exists(units: list<int>, amount: nat)
{
  exists chg :: 
    correct_change(units, amount, chg)
}

 
//***************************************************************************
//                                Question 2                                 
//***************************************************************************

 
function make_change(units: list<int>, amount: nat): list<int>
// We require that all units are strcitlt greater than 0;
// This ensures that we make progress with each recursive call
  requires all_nat(units);
{
  match units
  case Nil =>
    Nil
  case Cons(c, cs) =>
    if amount >= c then
      Cons(c, make_change(units, amount - c))
    else
      make_change(cs, amount)
}
 

// Change_SA.dfy

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
//                                Question 0                                 
//***************************************************************************

// This is Question 0.a
ghost method subsequence_impl_subset(xs: list, ys: list)
  requires subsequence(xs, ys);
  ensures subset(xs, ys);
{
// Notice that the proof goes by structural induction over ys
// and then by structural induction  over xs
// This is interesting, because subsequence is inductivelty defined over xs
    match ys {
    case Nil =>
    case Cons(y, ys') =>
      match xs {
        case Nil =>
        case Cons(x, xs') =>
          if x == y {
            subsequence_impl_subset(xs', ys');
          } else {
            subsequence_impl_subset(xs, ys');
          }
      }
  }
}
 
// Question 0.b - Question 0.c as exercise

// This is Question 0.a
ghost method prop_subset_transitive(xs: list, ys: list, zs:list)
  requires subset(xs, ys) && subset(ys,zs);
  ensures subset(xs, zs);
{ }

//***************************************************************************
//                                Question 1                                 
//***************************************************************************
ghost method Question1()
{
  var just1 := Cons(1, Nil);
  var cs := Cons(5, Cons(3, Nil));
  var chg := Cons(5, Nil);

  // NOTE: The counterexamples given here are not as interesting as I would have liked.
  // For example, in part Q1.k, a more interesting counterexanple woyuld have a sum >0
  // However, at the moment more interesting examples require many calc-steps
  // Perhaps Dafny will be modified to deal with that, and then we can make 
  // more interesting counterexamples

  // Q1.e, false:
  // assert elem(3, cs) &&   correct_change(cs, 5, chg) && !elem(3, chg);
  // does not go through; needs more calc-steps 
  
  // Q1.f, true: 
  assert forall c, cs, n, chg :: n > 0 && elem(c, chg) && correct_change(cs, n, chg) ==> elem(c, cs);
   
  // Q1.g, false
  // assert  correct_change(just1,0,Nil) && !(subset(just1,Nil));
  // The second assertion does not verify!!

   // Q1.h, false: 
   // assert forall cs, cs', n, chg :: n > 0 && subset(cs, cs') && correct_change(cs, n, chg) ==> correct_change(cs', n, chg);
   // does not verify, needs work

   // Q1.i False
   var cs2 := Cons(0, just1);
   // assert !(sum(cs2) <= sum(just1)  && correct_change(cs2, 1, just1)   ==> len(cs2) <= len(just1));
   // does not go through; needs more calc steps

   // Q1.j False
   // assert !(correct_change(Cons(2, Nil), 1, repeat(1, 1)));
   // does not yet go through

   // Q1.k, false: 
   var cs_e := Cons(0, just1);
   // assert !(sum(cs_e) <= sum(just1) && correct_change(cs_e, 1, just1) ==> len(cs_e) <= len(just1));
   // requires more calc steps
   // assert !(correct_change(Nil, 0, Nil) ==> len(Nil) > 0);
}

//***************************************************************************
//                                Question 2                                 
//***************************************************************************

predicate all_pos(xs: list<int>)
{  forall x:: elem(x,xs) ==> x>0 }
/* {
  match xs
  case Nil =>
    true
  case Cons(y, ys) =>
    y > 0 &&
    all_pos(ys)
}
*/

function make_change(units: list<int>, amount: nat): list<int>
// We require that all units are strcitlt greater than 0;
// This ensures that we make progress with each recursive call
  requires all_pos(units);
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

/*
ghost method  Question2b()
   ensures make_change( Cons(2, Cons(3, Nil)), 6) == Cons(2, Cons(2, Cons(2, Nil )));
   { }
// does not verify, but perhaps will do soon.
// Otherwise add calc-statements and expand the body
*/

/*
ghost method  Question2c()
   ensures make_change( Cons(3, Cons(2, Nil)), 6) == Cons(3, Cons(3, Nil));
   { }
// does not verify, but perhaps will do soon.
// Otherwise add calc-statements and expand the body
*/


//***************************************************************************
//                                Question 3                                 
//***************************************************************************

// Q3.a false
// Take c=3 cs=[5,3] n=10

ghost method Question3b(c: nat, cs: list<int>, n: nat)
  requires all_pos(cs) && elem(c, make_change(cs, n));
  ensures c <= n && elem(c, cs);
{
  match cs {
    case Nil =>
    case Cons(c1, cs') =>
      if n >= c1 {
        if c == c1 {
        } else {
          Question3b(c, cs, n - c1);
        }
      } else {
        assert elem(c, make_change(cs', n));
      }
  }
}

// Q3.c
// false: change_exists(3::5,10) && make_change(3::5,10)=3:3:3 
//            && ! correct_change(3::5,10,3:3:3)

// Q3.d
// false:  

// Q3.e
// false:

// Q3.f
// false

// Q3.g
// false

ghost method prop_subset_all_nat(cs': list<int>, cs: list<int>)
   requires subset(cs', cs) && all_nat(cs);
   ensures all_nat(cs');
{ }


ghost method Question3h(c: nat, cs: list<int>, cs': list<int>, n: nat)
  requires all_nat(cs) && subset(cs', cs) && change_exists(cs', n);
  ensures change_exists(cs, n);
{
	assert exists cs'':: subset(cs'', cs') && correct_change(cs',n,cs'');
	var cs''' :| subset(cs''', cs') && correct_change(cs',n,cs''');
	prop_subset_transitive(cs''',cs',cs);
	assert subset(cs''', cs);
	prop_subset_all_nat(cs',cs);
	assert correct_change(cs,n,cs''');
	assert change_exists(cs, n);
}

ghost method Question3hShorterProof(c: nat, cs: list<int>, cs': list<int>, n: nat)
  requires all_nat(cs) && subset(cs', cs) && change_exists(cs', n);
  ensures change_exists(cs, n);
{
	var cs''' :| subset(cs''', cs') && correct_change(cs',n,cs''');
	prop_subset_transitive(cs''',cs',cs);
	prop_subset_all_nat(cs',cs);
}

 

//***************************************************************************
//                                Question 4                                 
//***************************************************************************

// Q4.a
predicate good_units(cs: list<int>)
{
  all_pos(cs) &&
  elem(1, cs)
}


// Q4.b
ghost method prop_repeat_n_sum_n(n: nat, m: nat)
  ensures sum(repeat(m, n)) == m * n;
{
}

ghost method prop_repeat_n_subset<T>(cs: list<T>, c: T, n: nat)
  requires elem(c, cs);
  ensures subset(repeat(c, n), cs);
{
}

ghost method prop_good_implies_allnat(cs: list<int>)
  requires good_units(cs);
  ensures  all_nat(cs);
{ }

ghost method prop_good_units_make_change(cs: list<int>, n: nat)
  requires good_units(cs);
  ensures change_exists(cs, n);
{
  prop_good_implies_allnat(cs);
  calc {
    true;
		==> { prop_repeat_n_sum_n(n, 1);  }
    sum(repeat(1, n)) == n;
		 ==> { prop_repeat_n_subset(cs, 1, n); }
	sum(repeat(1, n)) == n && subset(repeat(1, n), cs);
		 ==> 
	correct_change(cs, n, repeat(1, n));
		 ==> 
	change_exists(cs, n);
  }
}

ghost method prop_good_units_make_change2(cs: list<int>, n: nat)
// Proof of the prop_good_units_make_change property
// but shorter
  requires good_units(cs);
  ensures change_exists(cs, n);
{
  prop_repeat_n_sum_n(n, 1);
  prop_repeat_n_subset(cs, 1, n);
}

// Question 4d
ghost method prop_always_change_implies_good(units: list<int>)
  requires forall n:nat:: change_exists(units,n);
{
  assert change_exists(units,1);
  assert exists chg ::  correct_change(units, 1, chg);
  var chg:list<int> :| correct_change(units, 1, chg);
  assert  all_nat(units) && subset(chg, units) && sum(chg) == 1;
  prop_nat_sum_one(chg);
  assert elem(1,chg);
}

ghost method prop_nat_sum_one( cs: list<int>)
  requires sum(cs)==1 && all_nat(cs);
  ensures   elem(1,cs);
  {  match cs {
        case Nil =>
		case Cons(c,cs') =>
		   {  if c==1   {  } 
		      else if c==0 { prop_nat_sum_one(cs');   }
			  else { assert c>1;
			         calc {
					 sum(cs); 
					 == 
					 c+sum(cs');
					  > { prop_nat_sum(cs'); }
					1; } 
					assert sum(cs)>1;  }
     }
  }
  }

  ghost method prop_nat_sum( cs: list<int>)
  requires all_nat(cs);
  ensures  sum(cs)>=0;
  {  
    match cs 
	  { case Nil =>
		case Cons(c,cs') =>
		   {  assert c>=0;
              calc { sum(cs); 
					     == 
					 c+sum(cs');
					     >=
					 0 + sum(cs');
					     >=
					 0 + 0;
					     ==
					 0; }
			  assert sum(cs)>=0; 
		 } 
     }
 } 
 
 
  

 //***************************************************************************
//                                Question 5                                 
//***************************************************************************

 
ghost method prop_make_change(cs: list<int>, n: nat)
   requires all_pos(cs) ; // good_units(cs);
  ensures  correct_change(cs, n, make_change(cs, n));
  // The following proof is somewhat surprising, in that i 
  // goes by inductions on cs and n.
  // also, that the interesting case is where n==0
/* {
   if n == 0 {
        prop_make_0(cs);
      }
   else
     { prop_make_change(cs, n-1); }
}
*/ 
 {
  match cs {
  // By induction over cs.
  // Notice that we only
    case Nil =>
    case Cons(c, _) =>
	  // now the proof goes by induction over n
	  // the base case is interesting
      if n == 0 {
        prop_make_0(cs);
      }
	  else {  prop_make_change(cs,n-1); }
	  // but the inductive step for n is not interesting
  }
}

 

ghost method prop_make_0(cs: list<int>)
  requires all_pos(cs);
  ensures make_change(cs, 0) == Nil;
// This is proven by induction on cs
{
  match cs {
    case Nil =>
    case Cons(c, cs) =>
  }
}

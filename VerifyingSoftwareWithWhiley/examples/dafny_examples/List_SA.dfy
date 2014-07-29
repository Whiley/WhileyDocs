// List_SA.dfy

datatype list<T> = Nil | Cons(T, list<T>);

function app(xs: list, ys: list): list
  ensures len(app(xs, ys)) >= len(xs);
{
  match xs
  case Nil =>
    ys
  case Cons(z, zs) =>
    Cons(z, app(zs, ys))
}

ghost method prop_app_Nil(xs: list)
  ensures app(xs, Nil) == xs;
{
}

ghost method prop_app_assoc(xs: list, ys: list, zs: list)
  ensures app(xs, app(ys, zs)) == app(app(xs, ys), zs);
{
}

function len(xs: list): nat
{
  match xs
  case Nil =>
    0
  case Cons(_, ys) =>
    1 + len(ys)
}

ghost method prop_len_app(xs: list, ys: list)
  ensures len(app(xs, ys)) == len(xs) + len(ys);
{
}

predicate elem<T>(n: T, xs: list)
{
  match xs
  case Nil =>
    false
  case Cons(y, ys) =>
    n == y || elem(n, ys)
}

ghost method prop_elem<T>(n: T, xs: list, ys: list)
  ensures elem(n, xs) ==> elem(n, app(xs, ys));
  ensures elem(n, ys) ==> elem(n, app(xs, ys));
{
}

function rev(xs: list): list
{
  match xs
  case Nil =>
    Nil
  case Cons(y, ys) =>
    app(rev(ys), Cons(y, Nil))
}

function count<T>(n: T, xs: list): nat
{
  match xs
  case Nil =>
    0
  case Cons(y, ys) =>
    var rest := count(n, ys); if y == n then 1 + rest else rest
}

// **************************************************************************
//                                 Question 1
// **************************************************************************

// Observe that del(n,xs) removes ALL occurrences of n from xs;
// This follows from QUestion 1.Property 2.

function del<T>(n: T, xs: list): list
{
  match xs
  case Nil =>
    Nil
  case Cons(y, ys) =>
    var r := del(n, ys); if n == y then r else Cons(y, r)
}

ghost method prop_del_notelem<T>(n: T, xs: list)
  requires !elem(n, xs);
  ensures del(n, xs) == xs;
{
}

ghost method prop_del_elem<T>(n: T, xs: list)
  ensures !elem(n, del(n, xs));
{
}

ghost method prop_del_app<T>(n: T, xs: list, ys: list)
  ensures del(n, app(xs, ys)) == app(del(n, xs), del(n, ys));
{
}

// **************************************************************************
//                                 Question 2
// **************************************************************************
function del1<T>(n: T, xs: list): list
// Observe that del1(n,xs) removes ONE occurrence of n from xs;
// This follows from Question 2.Property 2.
// Moreover, it removes the FIRST occurrence.
// his follows from Question 2.Property 3.
{
  match xs
  case Nil =>
    Nil
  case Cons(y, ys) =>
    if n == y then
      ys
    else
      Cons(y, del1(n, ys))
}

ghost method prop_del1_notelem<T>(n: T, xs: list)
  requires !elem(n, xs);
  ensures del1(n, xs) == xs;
{
}

ghost method prop_del1_elem_len<T>(n: T, xs: list)
  requires elem(n, xs);
  ensures len(xs) == 1 + len(del1(n, xs));
{
}

ghost method prop_del1_elem_app<T>(n: T, xs: list, ys: list)
  requires elem(n, xs);
  ensures forall ys :: app(del1(n, xs), ys) == del1(n, app(xs, ys));
{
}

// **************************************************************************
//                                 Question 3
// **************************************************************************
function dud_count<T>(n: T, xs: list): nat
{
  0
}

ghost method prop_countnotdud<T>(n: T, xs: list)
  requires elem(n, xs);
  ensures count(n, xs) > 0;
{
}

ghost method prop_count_add<T>(n: T, xs: list, ys: list)
  ensures count(n, xs) + count(n, ys) == count(n, app(xs, ys));
{
}

ghost method prop_count_rev<T>(n: T, xs: list)
  ensures count(n, xs) == count(n, rev(xs));
{
  match xs {
    case Nil =>
    case Cons(y, ys) =>
      calc {
        count(n, Cons(y, ys));
        == count(n, Cons(y, Nil)) + count(n, ys);
        == count(n, Cons(y, Nil)) + count(n, rev(ys));
        == count(n, rev(ys)) + count(n, Cons(y, Nil));
        == {  assert rev(Cons(y, ys)) == app(rev(ys), Cons(y, Nil));
              prop_count_add(n, rev(ys), Cons(y, Nil)); }
        count(n, rev(Cons(y, ys)));
      }
  }
}

ghost method prop_count_rev2<T>(n: T, xs: list)
// a more succint proof of the property from prop_count_rev
  ensures count(n, xs) == count(n, rev(xs));
{
  match xs {
    case Nil =>
    case Cons(y, ys) =>
      calc {
        count(n, Cons(y, ys));
        == { assert rev(Cons(y, ys)) == app(rev(ys), Cons(y, Nil));
             prop_count_add(n, rev(ys), Cons(y, Nil)); }
        count(n, rev(Cons(y, ys)));
      }
  }
}

ghost method prop_count_rev3<T>(n: T, xs: list)
// and an even more succint proof of the property from prop_count_rev
  ensures count(n, xs) == count(n, rev(xs));
{
  match xs {
    case Nil =>
    case Cons(y, ys) =>
      prop_count_add(n, rev(ys), Cons(y, Nil));
  }
}

ghost method prop_count_app_sum_dud<T>(n: T, xs: list, ys: list)
  ensures dud_count(n, app(xs, ys)) == dud_count(n, xs) + dud_count(n, ys);
{
}

ghost method prop_count_rev_dud<T>(n: T, xs: list)
  ensures dud_count(n, xs) == dud_count(n, rev(xs));

ghost method prop_count_sat_P<T>(n: T, xs: list)
  requires elem(n, xs);
  ensures count(n, xs) > 0;
{
}

ghost method prop_count_not_sat_P<T>(n: T, xs: list)
  requires elem(n, xs);
  ensures !(dud_count(n, xs) > 0);
{
}

// **************************************************************************
//                                 Question 4
// **************************************************************************

ghost method prop_rev_app(xs: list, ys: list)
  ensures rev(app(xs, ys)) == app(rev(ys), rev(xs));
{
  match xs {
    case Nil =>
      calc {
        rev(app(xs, ys));
        == rev(app(Nil, ys));
        == rev(ys);
        == 
		   {  prop_app_Nil(rev(ys));   }
           app(rev(ys), Nil);
        == app(rev(ys), rev(xs));
      }
    case Cons(z, zs) =>
      calc {
        rev(app(xs, ys));
        == rev(app(Cons(z, zs), ys));
        == rev(Cons(z, app(zs, ys)));
        == app(rev(app(zs, ys)), Cons(z, Nil));
        == app(app(rev(ys), rev(zs)), Cons(z, Nil));
        == {  prop_app_assoc(rev(ys), rev(zs), Cons(z, Nil));   }
           app(rev(ys), app(rev(zs), Cons(z, Nil)));
        == app(rev(ys), rev(xs));
      }
  }
}

ghost method prop_rev_app_shorter(xs: list, ys: list)
// a more succint proof of the property from prop_rev_app
  ensures rev(app(xs, ys)) == app(rev(ys), rev(xs));
{
  match xs {
    case Nil =>
      calc {
        rev(app(xs, ys));
        == {  prop_app_Nil(rev(ys));  }
        app(rev(ys), Nil);
      }
    case Cons(z, zs) =>
      calc {
        app(rev(app(zs, ys)), Cons(z, Nil));
        == { prop_app_assoc(rev(ys), rev(zs), Cons(z, Nil)); }
           app(rev(ys), app(rev(zs), Cons(z, Nil)));
        == app(rev(ys), rev(xs));
      }
  }
}

ghost method prop_revapp_shortest(xs: list, ys: list)
// and even more succint proof of the property from prop_rev_app
  ensures rev(app(xs, ys)) == app(rev(ys), rev(xs));
{
  match xs {
    case Nil =>
      prop_app_Nil(rev(ys));
    case Cons(x, xs) =>
      prop_app_assoc(rev(ys), rev(xs), Cons(x, Nil));
  }
}

// **************************************************************************
//                                 Question 5
// **************************************************************************
ghost method prop_rev_rev_id(xs: list)
  ensures rev(rev(xs)) == xs;
{
  match xs {
    case Nil =>
    case Cons(z, zs) =>
      calc {
        rev(rev(xs));
			== 
		rev(app(rev(zs), Cons(z, Nil)));
			== {  prop_rev_app(rev(zs), Cons(z, Nil));  }
        app(rev(Cons(z, Nil)), rev(rev(zs)));
			== 
		app(rev(Cons(z, Nil)), zs);
			== 
		xs;
      }
  }
}

ghost method prop_rev_rev_id_short(xs: list)
// a more succint proof of the property from prop_rev_rev_id
  ensures rev(rev(xs)) == xs;
{
  match xs {
    case Nil =>
    case Cons(z, zs) =>
      prop_rev_app(rev(zs), Cons(z, Nil));
  }
}

// **************************************************************************
//                                 Question 6
// **************************************************************************
function nth<T>(n: nat, xs: list): T
  requires len(xs) > n;
{
  match xs
  case Cons(y, ys) =>
    if n == 0 then
      y
    else
      nth(n - 1, ys)
}

// **************************************************************************
//                                 Question 7
// **************************************************************************
function itrev(xs: list, ys: list): list
{
  match xs
  case Nil =>
    ys
  case Cons(x, xs') =>
    itrev(xs', Cons(x, ys))
}

ghost method prop_itrev(xs: list)
  ensures itrev(xs, Nil) == rev(xs);
{
  calc {
    itrev(xs, Nil);
		== { prop_itrev_app(xs, Nil);   }
    app(rev(xs), Nil);
		== { prop_app_Nil(rev(xs)); }
	rev(xs);
  }
}

ghost method prop_itrev_app(xs: list, ys: list)
  ensures itrev(xs, ys) == app(rev(xs), ys);
{
  match xs {
    case Nil =>
    case Cons(z, zs) =>
      calc {
        itrev(xs, ys);
        == itrev(Cons(z, zs), ys);
        == itrev(zs, Cons(z, ys));
        == app(rev(zs), Cons(z, ys));
        == { prop_app_assoc(rev(zs), Cons(z, Nil), ys); }
           app(app(rev(zs), Cons(z, Nil)), ys);
        == app(rev(xs), ys);
      }
  }
}

ghost method prop_itrev_app_short(xs: list, ys: list)
// a more succint proof of the property from prop_itrev_app
  ensures itrev(xs, ys) == app(rev(xs), ys);
{
  match xs {
    case Nil =>
    case Cons(x, xs') =>
      prop_app_assoc(rev(xs'), Cons(x, Nil), ys);
  }
}

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

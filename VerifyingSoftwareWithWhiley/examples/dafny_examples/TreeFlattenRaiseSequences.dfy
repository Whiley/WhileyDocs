// TreeFlattenRaiseRequences.dfy
// This is the version which uses sequences.
// It is semantically identical to, but 
// easier to read than, the one using lists.

datatype Tree<T> = Leaf(T) | Node(Tree<T>, Tree<T>);

datatype Code<T> = Lf(T) | Nd;

function flatten(t: Tree): seq<Code>
{
  match t
  case Leaf(x) =>
    [Lf(x)]
  case Node(t1, t2) =>
    flatten(t1) + flatten(t2) + [Nd]
}

function size(t: Tree): nat
{
  match t
  case Leaf(x) =>
    1
  case Node(t1, t2) =>
    1 + size(t1) + size(t2)
}

// *********************************************************************
//                        1st Qestion
// *********************************************************************

ghost method preservesSizeLong(t: Tree)
// This is the long proof, where we justify
// each of the steps
  ensures size(t) == |flatten(t)|;
 
// *********************************************************************
//                        2nd Qestion
// *********************************************************************
function raise(cds: seq<Code>, ts: seq<Tree>): seq<Tree>
{
  if cds == [] then
    ts
  else
    raise(cds[1..], raiseOne(cds[0], ts))
}

function raiseOne(cd: Code, ts: seq<Tree>): seq<Tree>
{
  match cd
  case Lf(x) =>
    [Leaf(x)] + ts
  case Nd =>
        if |ts| < 2 then
      []
    else
      [Node(ts[1], ts[0])] + ts[2..]
}



ghost method Theorem(t: Tree)
   ensures raise(flatten(t), []) == [t];
 
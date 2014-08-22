// TreeFlattenRaiseRequencesSA.dfy
// Sample answers
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
{
  match t {
    case Leaf(x) =>
      calc {
        size(Leaf(x));
        == 1;
        == |[Lf(x)]|;
        == |flatten(Leaf(x))|;
      }
    case Node(t1, t2) =>
      calc {
        size(Node(t1, t2));
        == 1 + size(t1) + size(t2);
        == 1 + |flatten(t1)| + |flatten(t2)|;
        == |[Nd]| + |flatten(t1)| + |flatten(t2)|;
        == |flatten(t1) + flatten(t2) + [Nd]|;
        == |flatten(Node(t1, t2))|;
      }
  }
}

ghost method preservesSizeSI(t: Tree)
// This is thre shorter proof. It shows that
// we apply structural induction in t
  ensures size(t) == |flatten(t)|;
{
  match t {
    case Leaf(x) =>
    case Node(t1, t2) =>
  }
}

ghost method preservesSize(t: Tree)
// This is the most succinct version.
// Dafny finds the proof itself.
  ensures size(t) == |flatten(t)|;
{
}

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
// This is the longer proof, which shows all the
// necessary steps
// However, the important realization is,
// that the Theorem canot be proven inductively.
// Insdtead, we define a Lemma, which is a stronger
// version than the theorem
  ensures raise(flatten(t), []) == [t];
{
  calc {
     raise(flatten(t), []);
         == { assert flatten(t) + [] == flatten(t); }
    raise(flatten(t) + [], []);
        == { Lemma(t, [], []);  }
    raise([], [t]);
        == 
	[t];
  }
}

ghost method TheoremShortProof(t: Tree)
// This is a shorter proof. 
  ensures raise(flatten(t), []) == [t];
{
  assert flatten(t) + [] == flatten(t);
  Lemma(t, [], []);
}
ghost method Lemma(t: Tree, cds: seq<Code>, ts: seq<Tree>)
  ensures raise(flatten(t) + cds, ts) == raise(cds, [t] + ts);
{
  match t {
    case Leaf(x) =>
    case Node(t1, t2) =>
      calc {
        raise(flatten(t) + cds, ts);
            == 
		raise(flatten(t1) + flatten(t2) + [Nd] + cds, ts);
		// We want to apply the inductve hypothesis, but in order
		// to do that, we need to rearrange the terms combined through +
		// in the form ameable to the lemma. This rearrangement is done
		// through the assert-part.
            == { assert flatten(t1) + flatten(t2) + [Nd] + cds 
					== flatten(t1) + (flatten(t2) + [Nd] + cds); }
        raise(flatten(t1) + (flatten(t2) + [Nd] + cds), ts);
		    == { Lemma(t1, flatten(t2) + [Nd] + cds, ts); }
        raise(flatten(t2) + [Nd] + cds, [t1] + ts);
		// As above, in order to apply the inductve hypothesis,  
		//  we need to rearrange the terms combined through +
		// and we do this through the assert-part.
            == { assert flatten(t2) + [Nd] + cds == flatten(t2) + ([Nd] + cds); }
		raise(flatten(t2) + ([Nd] + cds), [t1] + ts);
		    == { Lemma(t2, [Nd] + cds, [t1] + ts);  }
		raise( [Nd] + cds, [t2] + ([t1] + ts));   
		    ==  { assert [t2] + [t1] + ts == [t2] + ([t1] + ts); }
		raise(cds, [Node(t1, t2)] + ts);
      }
  }
}

 

ghost method LemmaShort(t: Tree, cds: seq<Code>, ts: seq<Tree>)
  ensures raise(flatten(t) + cds, ts) == raise(cds, [t] + ts);
{
  match t {
    case Leaf(x) =>
    case Node(t1, t2) =>
      assert flatten(t1) + flatten(t2) + [Nd] + cds == flatten(t1) + (flatten(t2) + [Nd] + cds);
      assert [t2] + [t1] + ts == [t2] + ([t1] + ts);
      assert flatten(t2) + [Nd] + cds == flatten(t2) + ([Nd] + cds);
  }
}

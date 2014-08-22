// TreeFlattenRaiseLists_SA.dfy
// a sample answer
// This version uses lists, not sequences,
// and it uses optional values to encoide errors
// rahter than empty sequences as in the other version

// The data structures and their properties 
datatype list<T> = Nil | Cons(T, list<T>);
datatype tree<T> = Leaf(T) | Node(tree<T>,tree<T>);
datatype code<T> = Lf(T) | Nd;

function app(xs: list, ys: list): list
{
  match xs
  case Nil => ys
  case Cons(z, zs) => Cons(z, app(zs, ys))
}

ghost method prop_app_Nil(xs: list)
  ensures app(xs, Nil) == xs;
{ 
}

ghost method prop_app_assoc(
    xs: list, ys: list, zs: list)
  ensures app(xs, app(ys, zs)) == app(app(xs, ys), zs); 
{ 
}

function len(xs: list): nat
{
  match xs
  case Nil => 0
  case Cons(_, ys) => 1 + len(ys)
}

ghost method prop_len_app(xs: list, ys: list)
  ensures len(app(xs, ys)) == len(xs) + len(ys);
{ 
  match xs {
  case Nil =>
  case Cons(z, zs) => 
    prop_len_app(zs, ys);
  }
}

predicate elem<T>(n: T, xs: list<T>)
{
  match xs
  case Nil => false
  case Cons(y, ys) => 
    n == y || elem(n, ys)
}

ghost method prop_elem<T>(n: T, xs: list<T>, ys: list<T>)
  ensures elem(n, xs) ==> elem(n, app(xs, ys));
  ensures elem(n, ys) ==> elem(n, app(xs, ys));
{ }

function rev(xs: list): list
{
  match xs
  case Nil => Nil
  case Cons(y, ys) => 
    app(rev(ys), Cons(y, Nil))
}

function count<T>(n: T, xs: list<T>): nat
{
  match xs
  case Nil => 0
  case Cons(y, ys) => 
    var rest := count(n, ys);
    if (y == n)
	then 1 + rest
	else rest
}

// ******************************************************************
//                         1st Question
// ******************************************************************
function encode(t: tree): list<code>
{
	match t
	case Leaf(x) => Cons(Lf(x),Nil)
	case Node(t1,t2) => app( app(encode(t1),encode(t2)), Cons(Nd,Nil) )
}

  
function treeLen(t: tree): nat 
{
	match t
	case Leaf(x) => 1
	case Node(t1,t2) => 1 + len(encode(t1)) + len(encode(t2)) 
}


ghost method Lemma1(t: tree)
   ensures treeLen(t) == len(encode(t));
{
match t {
	case Leaf(x) =>  
	case Node(t1,t2) =>  
	{  calc{ 
	       treeLen(t);
		   ==
		   treeLen(t1) + 1 + treeLen(t2);
		   ==
		   len(encode(t1)) + 1 + len(encode(t2));
		   == { prop_len_app(encode(t1), encode(t2)); }
		   len(app(encode(t1),encode(t2))) +1;
		   == { prop_len_app(app(encode(t1),encode(t2)), Cons(Nd,Nil));
		        assert len(Cons(Nd,Nil))==1; }
		   len(app(app(encode(t1),encode(t2)),Cons(Nd,Nil)));
		   ==
		   len(encode(t));
		}

	}
	}
}

// ******************************************************************
//                         2nd Question
// ******************************************************************

function decode(cds: list<code>) : option<tree> 
{
	 decodeAux(cds,Nil)  
}

datatype option<T> = Res(T) | Error;

function decodeAux(cds: list<code>, ts: list<tree>) : option<tree> 
{
	match cds
	case Cons(x,cds') =>  
		(
		match x
		case Lf(x) => decodeAux(cds',Cons(Leaf(x),ts))
		case Nd =>
			( 
			  match ts 
			  case Nil => Error
			  case Cons(t1,ts') =>
			     ( 
				   match ts' 
			       case Cons(t2,ts'') => decodeAux(cds',Cons(Node(t2,t1),ts''))
			       case Nil => Error
			       )
		      )
		)
    case Nil =>  
     (  
         match ts  
            case Cons(t,ts') => Res(t)
            case Nil => Error	
      )
}

ghost method Lemma(t: tree, cds: list<code>, ts:list<tree>)
    ensures decodeAux( app(encode(t),cds), ts)==decodeAux(cds,Cons(t,ts));
	decreases t;
	{

	match t {
	case Leaf(x) => 
	case Node(t1,t2) => 
	   { calc{
	        decodeAux( app(encode(t),cds), ts);
			==
			decodeAux( app( app(app(encode(t1),encode(t2)),Cons(Nd,Nil)) ,cds), ts);
			== { prop_app_assoc(encode(t1),  encode(t2), Cons(Nd,Nil)); }
			decodeAux( app(  app(encode(t1), app(encode(t2),Cons(Nd,Nil)))  ,cds), ts);
			== { prop_app_assoc(encode(t1),  app(encode(t2), Cons(Nd,Nil)), cds); }
			decodeAux( app(  encode(t1), app( app(encode(t2),Cons(Nd,Nil)) ,cds)), ts);
			==  { Lemma(t1, app( app(encode(t2),Cons(Nd,Nil)) ,cds), ts); }
			decodeAux(  app( app(encode(t2),Cons(Nd,Nil)) ,cds), Cons(t1,ts));
			==  {  prop_app_assoc(encode(t2),   Cons(Nd,Nil), cds); }  
			decodeAux(  app(encode(t2), app(Cons(Nd,Nil) ,cds)), Cons(t1,ts));
			== { Lemma(t2, app(Cons(Nd,Nil),cds),Cons(t1,ts) ); }
			decodeAux( app(Cons(Nd,Nil),cds), Cons(t2,Cons(t1,ts)) );
			==
			decodeAux( cds, Cons(t,ts));
	   }    }
	}    
}

ghost method Theorem(t: tree)
   ensures decode(encode(t)) == Res(t);
{ 
    calc{
	   decode(encode(t));
	   ==
       decodeAux( encode(t), Nil);
	   == { prop_app_Nil(encode(t));
	        assert app(encode(t),Nil) == encode(t); }
       decodeAux( app(encode(t),Nil), Nil);
	   == { Lemma( t, Nil, Nil); } 
	   decodeAux(Nil, Cons(t,Nil));
	   ==
	   Res(t);
	   }
}

/*
The following predicate is not used, but is a sanity
condition oin intermediate calls of decode 

predicate matching(cds: list<code>, ts: list<tree>)  
{
	match cds
	case Cons(x,cds') =>  
	   ( 
	    match x
		case Lf(x) => matching(cds',Cons(Leaf(x),ts))
		case Nd =>
			( 
			  match ts 
			  case Nil => false
			  case Cons(t1,ts') =>
			     ( 
				   match ts' 
			       case Cons(t2,ts'') => matching(cds',Cons(Node(t2,t1),ts''))
			       case Nil => false
			      )
		    )
	   )
    case Nil =>  
	         (  
			     match ts  
                 case Cons(t,ts') => true
                 case Nil => false	
			 )
}
*/
 



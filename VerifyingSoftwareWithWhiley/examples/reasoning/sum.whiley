function sum(int[] items, int i) -> (int r)
// All elements of items are natural
requires all { k in 0..|items| | items[k] >= 0 }
// Index is at most one past bounds of array
requires 0 <= i && i <= |items|
// Result is natural
ensures r >= 0:
  // 0 $\le$ i $\land$ i $\le$ |items| $\land$ $\forall$ k.\big(0 <= k $\land$ k < |items| ==> items[k] $\ge$ 0\big)
  if i == |items|:
    // i == |items| $\land$ ...
    return 0
  else:
    // 0 $\le$ i $\land$ i $\le$ |items| $\land$ i $\neq$ |items| $\land$
    // $\;\;\;$ $\forall$ k.\big(0 <= k $\land$ k < |items| ==> items[k] $\ge$ 0\big)
    int x = items[i]
    // x $\ge$ 0 $\land$ 0 $\le$ i $\land$ i $\le$ |items| $\land$ i $\neq$ |items| $\land$ $\forall$ k.\big(...)
    int y = sum(items,i+1)
    // y $\ge$ 0 $\land$ x $\ge$ 0 $\land$ 0 $\le$ i $\land$ i $\le$ |items| $\land$ i $\neq$ |items| $\land$ $\forall$ k.\big(...)
    return x + y
        
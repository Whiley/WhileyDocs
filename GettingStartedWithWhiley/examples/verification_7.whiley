type ArrayOfNats is (int[] items)
// does not exist an x in items where is less-than zero
where !some { i in 0..|items| | items[i] < 0 }

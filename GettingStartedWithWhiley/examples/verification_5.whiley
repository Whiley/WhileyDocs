type ArrayOfNats is (int[] items)
// every x in items must be greater-or-equal-to zero
where all { i in 0..|items| | items[i] >= 0 }

// A type representing lists of natural numbers
type natlist is (int[] xs) where 
    all { i in 0 .. |xs| | xs[i] >= 0 }
    
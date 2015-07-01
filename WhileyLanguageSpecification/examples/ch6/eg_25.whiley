// Type of function which accepts and returns an int
type fun_t is function(int)->int

// Apply a function to every element of a list
function map(fun_t fn, [int] xs) -> [int]:
    int i = 0
    while i < |xs|:
        xs[i] = fn(xs[i])
        i = i + 1
    return xs

// Add y to every element of items
function addAll([int] items, int y) -> [int]:
    fun_t fn = &(int x -> x + y)
    return map(fn,items)

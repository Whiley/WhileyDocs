function f(int x) -> int:
    debug "f(int) called"
    if x == 1 || x == 0:
       return x
    else:
       return f(x-1) + f(x-2)

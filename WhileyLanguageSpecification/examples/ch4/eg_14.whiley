import string from whiley.lang.ASCII

type Expr is int | string // simple expression forms

function evaluate(Expr e, {string=>int} environment) -> int:
    if e is int:
        // expression is constant, so return this directly
        return e
    else:
        // expression is variable, so look up its value in environment
        return environment[e]

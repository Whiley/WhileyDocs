method f1([int] x, [int] y):
    x = y       // variable assignment

method f2({int f} x, int y):
    x.f = y     // field assignment

method f3([int] x, int i, int y):
    x[i] = y    // list assignment

method f4([{int f}] x, int i, int y):
    x[i].f = y  // compound assignment

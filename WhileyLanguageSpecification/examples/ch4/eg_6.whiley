function floor(real x) -> int:
    int num / int den = x    // extract numerator and denominator
    int r = num / den        // integer division
    if x < 0.0 && den != 1: 	 
        return r - 1 
    else:
        return r 

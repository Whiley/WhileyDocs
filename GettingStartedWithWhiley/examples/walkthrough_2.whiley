function vectorMultiply([real] vector, real scalar) -> [real]:
    //
    for i in 0 .. |vector|:
        vector[i] = vector[i] * scalar
    return vector

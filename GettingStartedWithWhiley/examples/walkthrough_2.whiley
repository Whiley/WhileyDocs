function vectorMultiply([real] vector, real scalar) -> [real]:
    //
    int i = 0
    while i < |vector|:
        vector[i] = vector[i] * scalar
        i = i + 1
    return vector

function vectorMultiply(int[] vector, int scalar) -> int[]:
    //
    int i = 0
    while i < |vector|:
        vector[i] = vector[i] * scalar
        i = i + 1
    return vector

method main():
    // Array initialiser
    int[] vec1 = [1,2,3]
    int[] r1 = vectorMultiply(vec1,2)
    assert r1 == [2,4,6]
    //
    // Array generator
    int[] vec2 = [2; 4]
    int[] r2 = vectorMultiply(vec2,2)
    assert r2 == [4,4,4,4]

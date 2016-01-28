function add(int[] v1, int[] v2) -> (int[] v3)
requires |v1| == |v2|
ensures |v1| == |v3|:
    //
    int i=0
    while i < |v1|:
        v1[i] = v1[i] + v2[i]
        i = i + 1
    return v1

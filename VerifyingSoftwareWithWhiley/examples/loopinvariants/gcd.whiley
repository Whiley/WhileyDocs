function gcd(int a, int b) => (int r)
// Parameters must be naturals
requires a >= 0 && b >= 0
// Return must be a natural
ensures r >= 0:
    //
    if(a == 0):
        return b		   
    //
    while(b != 0):
        if(a > b):
            a = a - b
        else:
            b = b - a
    //
    return a

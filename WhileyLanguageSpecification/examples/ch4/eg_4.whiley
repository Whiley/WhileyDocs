import whiley.lang.ASCII 
// convert a byte into a string
function toString(byte b) -> ASCII.string:
    ASCII.string r = "b"
    int i = 0
    while i < 8:
        if (b & 00000001b) == 00000001b:
            r = "1" ++ r
        else:
            r = "0" ++ r
        b = b >> 1	
        i = i + 1
    return r

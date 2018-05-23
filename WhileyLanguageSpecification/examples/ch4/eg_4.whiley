import std.ascii
// convert a byte into a string
function toString(byte b) -> ascii.string:
    ascii.string r = ['0'; 8]
    int i = 0
    while i < 8:
        if (b & 0b00000001) == 0b00000001:
            r[i] = '1'
        b = b >> 1	
        i = i + 1
    return r

import u8 from std.integer

function toUnsignedByte(u8 v) -> byte:
    //
    byte mask = 0b00000001
    byte r = 0b0
    int i = 0
    while i < 8:
        if (v % 2) == 1:
            r = r | mask
        v = v / 2
        mask = mask << 1
        i = i + 1
    return r  

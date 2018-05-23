// Check whether a given bit is zero
function isZero(byte b, int bit) -> bool:
    byte mask = 0b1 << bit
    return (b & ~mask) == b
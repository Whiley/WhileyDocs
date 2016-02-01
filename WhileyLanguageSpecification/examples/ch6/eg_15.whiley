// Check whether a given bit is zero
function isZero(byte b, int bit) -> bool:
    byte mask = 1b << bit
    return (b & ~mask) == b
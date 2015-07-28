constant CF is 0
constant PF is 2
constant AF is 4
constant ZF is 6

function setFlag(byte flags, int flag) -> byte:
    byte mask = 1b << flag
    return flags | mask

function getFlag(byte flags, int flag) -> bool:
    byte mask = 1b << flag
    return (flags & mask) != 0
import string from std.ascii

constant Void is 3
constant Boolean is 4
constant Char is 5
constant Float is 6
constant Double is 7
constant Byte is 8
constant Short is 9
constant Int is 10
constant Long is 11

type Primitive is (int x) where Void <= x && x <= Long

function toDescriptorString(Primitive t) -> string:
    switch t:
        case Boolean:
            return "Z"
        case Byte:
            return "B"
        case Char:
            return "C"
        case Short:
            return "S"
        case Int:
            return "I"
        case Long:
            return "J"
        case Float:
            return "F"
        default:
            return "D"

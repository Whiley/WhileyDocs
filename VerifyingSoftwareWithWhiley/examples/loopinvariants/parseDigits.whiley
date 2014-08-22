// Skip over a sequence of digits in an input string
function parseDigits(int pos, string input) => (int npos)
// Precondition: current position must be valid index in input
requires pos >= 0 && pos < |input|
// Postcondition: new position must be valid index in input, 
//                or one past (meaning finished parsing)
ensures pos >= pos && pos <= |input|:    
    //
    while pos < |input| && Char.isDigit(input[pos]):
        pos = pos + 1
    //
    return pos

function replace(string str, char old, char n) => string:
    //
    int i = 0
    while i < |str|:
        if str[i] == old:
            str[i] = n
        i = i + 1
    return str    

// A word is simply a string of characters
function equal (string str1, string str2) => (bool r)
// If result is true, size of both parmaters is the same
ensures r ==> |str1| == |str2|
// If result is true, every element of both parameters matches
ensures r ==> all { i in 0..|str1| | str1[i] == str2[i] }:
    //
    if |str1| == |str2|:
        int i = 0
        //
        while (i < |str1|) 
        // i remains positive around the loop
        where i >= 0 && i <= |str1|
        // all elements up to i are known to match
        where all { j in 0 .. i | str1[j] == str2[j] }:
            //
            if str1[i] != str2[i]:
                return false
            i = i + 1    
        return true
    else:
        return false
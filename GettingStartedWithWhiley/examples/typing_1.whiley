function indexOf(string str, char c) => null|int:
   int i = 0
   while i < |str|:
      if str[i] == c:
         return i
      i = i + 1
   return null

function split(string str, char c) => [string]:
   int|null idx = indexOf(str,c)
   // idx has type null$|$int
   if idx is int:
       // idx now has type int
       string below = str[0..idx]
       string above = str[idx..]
       return [below,above]
   else:
       // idx now has type null
       return [str] // no occurrence
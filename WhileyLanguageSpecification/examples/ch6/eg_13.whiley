function negAccess(int i, [int] items) -> int
requires -|items| <= i && i < |items|:
   //
   if i < 0:
       return -items[-(i+1)]
   else:
       return items[i]

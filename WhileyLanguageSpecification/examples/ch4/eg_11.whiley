import std.ascii

type Writer is { 
   method write(byte[]) -> int,
   ...
}
type PrintWriter is { 
   method write(byte[]) -> int,
   method println(ascii.string),
   ...
}
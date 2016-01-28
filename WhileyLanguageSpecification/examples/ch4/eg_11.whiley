import whiley.lang.ASCII

type Writer is { 
   method write(byte[]) -> int,
   ...
}
type PrintWriter is { 
   method write(byte[]) -> int,
   method println(ASCII.string),
   ...
}
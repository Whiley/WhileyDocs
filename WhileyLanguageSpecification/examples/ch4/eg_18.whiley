type Reader is { 
   method read(int)->(byte[]),
   ...
}
type Writer is { 
   method write(byte[])->(int),
   ...
}
type ReaderWriter is Reader & Writer

import whiley.lang.ASCII
function isUpperCase(ASCII.char c) -> bool:
    return 'A' <= c && c <= 'Z'

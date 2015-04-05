type Node is { Tree left, Tree right, int data }
type Tree is null | Node

function sizeOf(Tree t) -> int:
    if t == null:
        return 0
    else:
        return 1 + sizeOf(t.left) + sizeOf(t.right)

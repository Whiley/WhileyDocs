import whiley.lang.Math

type Tree is null | { int data, Tree left, Tree right }

function height(Tree t) -> int:
    if t is null:
        // height of empty tree is zero
        return 0
    else:
        // height is this node plus maximum height of subtrees
        return 1 + Math.max(height(t.left), height(t.right))

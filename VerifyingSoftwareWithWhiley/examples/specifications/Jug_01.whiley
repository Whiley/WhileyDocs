type nat is (int x) where x >= 0

// This example is based on the classic water jugs puzzle.  However,
// I've simplified it by having only two jugs.

constant SMALL_SIZE is 3
constant MEDIUM_SIZE is 5

type State is {
    nat small,
    nat medium
} where small <= SMALL_SIZE && 
        medium <= MEDIUM_SIZE

function pourSmall2Medium(State jugs) => (State r)
// Ensure that the amount of water remains unchanged
ensures (r.small + r.medium + r.large) == (jugs.small + jugs.medium + jugs.large):
    //
    int amount = MEDIUM_SIZE - jugs.medium
    //
    if amount > jugs.small:
        // indicates we're emptying the small jug
        jugs.medium = jugs.medium + jugs.small
        jugs.small = 0
    else:
        // indicates we're filling up the medium jug
        jugs.medium = MEDIUM_SIZE
        jugs.small = jugs.small - amount
    // Done
    return jugs
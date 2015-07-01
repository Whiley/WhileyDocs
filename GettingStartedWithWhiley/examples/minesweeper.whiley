import whiley.lang.Math

// =================================================================
// Squares
// =================================================================

// An exposed square is one which has been exposed by the player, and 
// displays its "rank".  The rank is the count of bombs in the eight 
// directly adjacent squares.
type ExposedSquare is { 
  int rank,       // Number of bombs in adjacent squares
  bool holdsBomb  // true if the square holds a bomb
}

// A hidden square is one which has yet to be revealed by the player.  A
// hidden square may contain a bomb and/or have been "flagged" by the
// player.
type HiddenSquare is { 
  bool holdsBomb,  // true if the square holds a bomb
  bool flagged     // true if the square is flagged
}

// Every square on the board is either an exposed square or a hidden
// square.
type Square is ExposedSquare | HiddenSquare

export 
// ExposedSquare constructor
function ExposedSquare(int rank, bool bomb) -> ExposedSquare:
    return { rank: rank, holdsBomb: bomb }

export 
// HiddenSquare constructor
function HiddenSquare(bool bomb, bool flag) -> HiddenSquare:
    return { holdsBomb: bomb, flagged: flag }

// =================================================================
// Board
// =================================================================

type Board is {
   [Square] squares,  // List of squares making up the board
   int width,         // Width of the game board (in squares)
   int height         // Height of the game board (in squares)
}


export 
// Create a board of given dimensions which contains no bombs, and
// where all squares are hidden.
function Board(int width, int height) -> Board:
    [Square] squares = []
    int i = 0
    //   
    while i < width * height:
      squares = squares ++ [HiddenSquare(false,false)]
      i = i + 1
    //
    return {
        squares: squares,
        width: width,
        height: height
    }

export
// Return the square on a given board at a given position
function getSquare(Board b, int col, int row) -> Square:
    int rowOffset = b.width * row // calculate start of row
    return b.squares[rowOffset + col]

export
// Set the square on a given board at a given position
function setSquare(Board b, int col, int row, Square sq) -> Board:
    int rowOffset = b.width * row // calculate start of row
    b.squares[rowOffset + col] = sq
    return b

// =================================================================
// Game Play
// =================================================================

export
// Flag (or unflag) a given square on the board.  If this operation is not permitted, then do nothing
// and return the board; otherwise, update the board accordingly.
function flagSquare(Board b, int col, int row) -> Board:
   Square sq = getSquare(b,col,row)
   // check whether permitted to flag
   if sq is HiddenSquare:
      // yes, is permitted so reverse flag status and update board
      sq.flagged = !sq.flagged
      b = setSquare(b,col,row,sq)
   //
   return b

// Determine the rank of a given square on the board.  That is the
// count of bombs in the adjacent 8 squares.  Observe that, in this
// implementation, we also count any bomb on the central square itself.
// This does not course any specific problem since an exposed square
// containing a bomb signals the end of the game anyway.
function determineRank(Board b, int col, int row) -> int:
    int rank = 0
    // Calculate the rank
    for r in Math.max(0,row-1) .. Math.min(b.height,row+2):
        for c in Math.max(0,col-1) .. Math.min(b.width,col+2):
            Square sq = getSquare(b,c,r)
            if sq.holdsBomb:
                rank = rank + 1
    //
    return rank

export
// Attempt to recursively expose blank hidden square, starting from a given position.
function exposeSquare(Board b, int col, int row) -> Board:
    // Check whether is blank hidden square
    Square sq = getSquare(b,col,row)
    int rank = determineRank(b,col,row)
    if sq is HiddenSquare:       
        // yes, so expose square
        sq = ExposedSquare(rank,sq.holdsBomb)
        b = setSquare(b,col,row,sq)
        if rank == 0:
            // now expose neighbours
            return exposeNeighbours(b,col,row)
    //
    return b

// Recursively expose all valid neighbouring squares on the board
function exposeNeighbours(Board b, int col, int row) -> Board:
    for r in Math.max(0,row-1) .. Math.min(b.height,row+2):
       for c in Math.max(0,col-1) .. Math.min(b.width,col+2):
           b = exposeSquare(b,c,r)
    //
    return b

// Determine whether the game is over or not and, if so, whether or
// not the player has one.  The game is over and the player has lost 
// if there is an exposed square on the board which contains a bomb.  
// Likewise, the game is over and the player has one if there are no 
// hidden squares which don't contain a bomb.
export
function isGameOver(Board b) -> (bool,bool):
    bool isOver = true
    bool hasWon = true
    for i in 0 .. |b.squares|:
        Square sq = b.squares[i]
        if sq is HiddenSquare && !sq.holdsBomb:
            // Hidden square which doesn't hold a bomb so game may not be over
            isOver = false
        else if sq is ExposedSquare && sq.holdsBomb:
            // Exposed square which holds a bomb so game definitely over
            isOver = true
            hasWon = false
            break
    //
    return isOver, hasWon
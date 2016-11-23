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
   Square[] squares,  // Array of squares making up the board
   int width,         // Width of the game board (in squares)
   int height         // Height of the game board (in squares)
}


export 
// Create a board of given dimensions which contains no bombs, and
// where all squares are hidden.
function Board(int width, int height) -> Board:
    Square[] squares = [HiddenSquare(false,false); width * height]
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
    int r = Math.max(0,row-1)
    while r != Math.min(b.height,row+2):
        int c = Math.max(0,col-1)
        while c != Math.min(b.width,col+2):
            Square sq = getSquare(b,c,r)
            if sq.holdsBomb:
                rank = rank + 1
            c = c + 1
        r = r + 1
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
    int r = Math.max(0,row-1)
    while r != Math.min(b.height,row+2):
        int c = Math.max(0,col-1)
        while c != Math.min(b.width,col+2):
           b = exposeSquare(b,c,r)
           c = c + 1
        r = r + 1
    //
    return b

// Determine whether the game is over or not and, if so, whether or
// not the player has one.  The game is over and the player has lost 
// if there is an exposed square on the board which contains a bomb.  
// Likewise, the game is over and the player has one if there are no 
// hidden squares which don't contain a bomb.
export
function isGameOver(Board b) -> (bool gameOver, bool playerWon):
    bool isOver = true
    bool hasWon = true
    int i = 0
    while i < |b.squares|:
        Square sq = b.squares[i]
        if sq is HiddenSquare && !sq.holdsBomb:
            // Hidden square which doesn't hold a bomb so game may not be over
            isOver = false
        else if sq is ExposedSquare && sq.holdsBomb:
            // Exposed square which holds a bomb so game definitely over
            isOver = true
            hasWon = false
            break
        i = i + 1
    //
    return isOver, hasWon

import whiley.lang.System

method printBoard(Board board, System.Console console):
    int row = 0
    while row != board.height:
        printRow(row,board,console)
        row = row + 1
    //

method printRow(int row, Board board, System.Console console):
    // Print Side Wall
    console.out.print("|")
    int col = 0
    while col != board.width:
        printSquare(getSquare(board,col,row),console)
        col = col + 1
    // Print Side Wall
    console.out.println("|")

method printSquare(Square sq, System.Console console):
    if sq is HiddenSquare:
        if sq.flagged:
            console.out.print("P")
        else:
            console.out.print("O")
    else if sq.holdsBomb:
        console.out.print("*")
    else if sq.rank == 0:
        console.out.print(" ")
    else:
        console.out.print(sq.rank)

// expose signals the player exposes a square (true) or flags it (false)
type Move is { bool expose, int col, int row }
        
constant MOVES is [
    {expose: true, col: 0, row: 0},       // First move, expose square 0,0
    {expose: false, col: 0, row: 1},      // Second move, flag square 0,1
    {expose: true, col: 2, row: 0}        // Third move, expose square 2,0
]

function constructExampleBoard() -> (Board r):
    Board board = Board(10,5)
    // Place bombs on the board
    board = setSquare(board,0,1,HiddenSquare(true,false))
    board = setSquare(board,2,3,HiddenSquare(true,false))
    board = setSquare(board,3,3,HiddenSquare(true,false))
    //
    return board

method applyMove(System.Console console, Board board, Move m) -> (Board r):
    if m.expose:
        console.out.println("Player exposes square")
        return exposeSquare(board,m.col,m.row)
    else:
        console.out.println("Player flags square")
        return flagSquare(board,m.col,m.row)

method main(System.Console console):
    //
    Board board = constructExampleBoard()
    int i = 0
    //
    while i < |MOVES|:
        board = applyMove(console,board,MOVES[i])
        printBoard(board,console)
        i = i + 1
    
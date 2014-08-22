function flapTriggered(bool catIn, bool catOut) => (bool nCatIn, bool nCatOut)
// Cat must be either in or out (but not both)
requires catIn != catOut
// If cat was in, then now out and vice-versa
ensures nCatIn == !catIn && nCatOut == !catOut:
    //
    return !catIn, !catOut

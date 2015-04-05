// Swap contents of heap-allocated int variables
method swap(&int pX, &int pY):
    int tmp = *pX
    *pX = *pY
    *pY = tmp

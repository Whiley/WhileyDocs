// Return the set of all keys which map to a given value
function keysOf({int=>string} map, string value) => {int}:
    //
    {int} result = {} // initialise result with empty set
    for k,v in map:      // loop over every key,value pair in map
        if v == value:
            result = result + {k} // add matching keys to result set
    // return result
    return result

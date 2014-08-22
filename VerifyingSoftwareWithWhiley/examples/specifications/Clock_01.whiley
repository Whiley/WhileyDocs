type Time is {
    int hours,
    int seconds
}

function tick(Time t) => Time
// There are exactly 24 hours in a day
requires t.hours >= 0 && t.hours < 24
// There are exactly 60 minutes in an hour
requires t.hours >= 0 && t.hours < 60:
    //
    if t.seconds == 59:
        t.hours = t.hours + 1
        t.seconds = 0
    else:
        t.seconds = t.seconds + 1
    //
    return t
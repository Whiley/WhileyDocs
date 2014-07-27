constant Jan is 1
constant Feb is 2
constant Mar is 3
constant Apr is 4
constant May is 5
constant Jun is 6
constant Jul is 7
constant Aug is 8
constant Sep is 9
constant Oct is 10
constant Nov is 11
constant Dec is 12

type Date is {
    int day,
    int month,
    int year
} where 1 <= day &&
    // 30 days hath September, April, June and November
    (month == Sep || month == Apr || month == Jun || month == Nov) ==> day < 31 &&
    // All the rest have 31
    day <= 31 &&
    // Except Februrary, which has 29 (since we're ignoring leap years)
    (month == Feb) ==> day <= 29
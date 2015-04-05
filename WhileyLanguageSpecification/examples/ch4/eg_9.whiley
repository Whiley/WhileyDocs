// Attempt to update first element
method update1st(&[int] list, int value) -> void:
    // First, check whether list is empty or not
    if (*list) != []:
       // Then, update 1st element
       (*list)[0] = value
    // done

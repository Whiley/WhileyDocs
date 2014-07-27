function calculateChange(int fiveDollarNotes) => { int twentyCents, int fiftyCents }
// Require one or more fiveDollarNotes to turn into change
requires fiveDollarNotes > 0
// Total return should match the amount given
ensures twentyCents * 20 + fiftyCents * 50 == fiveDollarNotes * 500:
    //
    return {
        twentyCents: 0,
        fiftyCents: fiveDollarNotes * 10
    }
    

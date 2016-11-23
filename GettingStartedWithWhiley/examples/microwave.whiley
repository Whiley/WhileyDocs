// This is based on the classical "microwave" oven state
// machine problem. The purpose is to ensure that the
// door is never open when the microwave is heating.
//
// By David J. Peace, 2013

type nat is (int x) where x >= 0

// First, define the state of the microwave.
type Microwave is ({
        bool heatOn, // if true, the oven is cooking
        bool doorOpen, // if true, the door is open
        nat timer // timer setting (in seconds)
} m) where !m.doorOpen || !m.heatOn

// The clock tick event is signaled by the internal clock
// circuits of the microwave. It is triggered every second
// in order to implement timed cooking.
function clockTick(Microwave m) -> Microwave:
        //
        if m.heatOn && m.timer == 0:
                // Timer has expired
                m.heatOn = false
        else if m.heatOn:
                // Still time left
                m.timer = m.timer - 1
        // If heating is not on, then ignore this event
        return m

// Set the timer on the microwave. This can't be done if
// the microwave is cooking.
function setTimer(Microwave m, nat value) -> Microwave
requires !m.heatOn:
        //
        m.timer = value
        return m

// Signals that the "start cooking" button has been pressed.
function startCooking(Microwave m) -> Microwave:
        //        
        // Here, we check the all important safety propery
        if !m.doorOpen:
                m.heatOn = true
        return m

// A door closed event is triggered when the sensor detects that the door is closed.
function doorClosed(Microwave m) -> Microwave
requires m.doorOpen:
        //
        m.doorOpen = false
        return m

// A door opened event is triggered when the sensor detects that the door is opened.
function doorOpened(Microwave m) -> Microwave
requires !m.doorOpen:
        //
        m.doorOpen = true
        m.heatOn = false
        return m


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


extends Node

var tick = 0
var tickLengthIndex = 2
var possibleTickLengths = [0.1, 0.25, 0.5, 1.0]

var clock = 0
var isPaused := true

onready var grid := $Grid
onready var clockLabel := $ClockLabel

signal update

func _init():
    pass
    
func _ready():
    grid.updateVisuals()
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if isPaused:
        updateUI()
        return 
        
    tick += delta
    var tickLength = possibleTickLengths[tickLengthIndex]
    
    if tick > tickLength:
        tick -= tickLength
        clock += 1
        emit_signal("update")
        updateUI()

    
func _input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()  
        if event.pressed and event.scancode == KEY_SPACE:
            isPaused = !isPaused
        if event.pressed and event.scancode == KEY_UP:
            decreaseTickLength()
        if event.pressed and event.scancode == KEY_DOWN:
            increaseTickLength()
            
func updateUI():
    if isPaused:
        clockLabel.text = "Paused"
    else:
        clockLabel.text = String(clock)  
        
# Slower ticks    
func increaseTickLength():
    tickLengthIndex += 1
    if tickLengthIndex >= possibleTickLengths.size():
        tickLengthIndex = possibleTickLengths.size() - 1
    print("Tick: ", possibleTickLengths[tickLengthIndex], " seconds")    
        
# Faster ticks
func decreaseTickLength():
    tickLengthIndex -= 1
    if tickLengthIndex < 0:
        tickLengthIndex = 0
    print("Tick: ", possibleTickLengths[tickLengthIndex], " seconds")            
    

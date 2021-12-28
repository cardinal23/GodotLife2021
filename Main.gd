extends Node

var tick = 0
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
    
    if tick > 1:
        tick -= 1
        clock += 1
        emit_signal("update")
        updateUI()

    
func _input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()  
        if event.pressed and event.scancode == KEY_SPACE:
            isPaused = !isPaused
            
func updateUI():
    if isPaused:
        clockLabel.text = "Paused"
    else:
        clockLabel.text = String(clock)  
            
    

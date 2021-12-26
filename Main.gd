extends Node

var tick = 0
var clock = 0
var isPaused := false

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
        return 
        
    tick += delta
    
    if tick > 1:
        tick -= 1
        clock += 1
        clockLabel.text = String(clock)
        emit_signal("update")
    
func _input(_event):
    pass            
            
    

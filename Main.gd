extends Node

var tick = 0
var clock = 0

onready var grid := $Grid
onready var clockLabel := $ClockLabel

signal update

func _init():
    pass
    
func _ready():
    grid.update()
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    tick += delta
    
    if tick > 1:
        tick -= 1
        clock += 1
        clockLabel.text = String(clock)
        emit_signal("update")
    
func _input(_event):
    pass            
            
    

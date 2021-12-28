extends ColorRect

class_name Cell

export(Global.CellState) var state = Global.CellState.DEAD

var position: Vector2
var neighborCount := 0

onready var positionLabel = $PositionLabel
onready var neighborLabel = $NeighborLabel

func _ready():
    pass # Replace with function body.
    
func isAlive():
    return state == Global.CellState.ALIVE
    
func isDead():
    return state == Global.CellState.DEAD
         
func toggledState():
    if state == Global.CellState.ALIVE:
        return Global.CellState.DEAD
    elif state == Global.CellState.DEAD:
        return Global.CellState.ALIVE

func update():
    var positionString = "%s,%s"
    positionLabel.text = positionString % [position.x, position.y]
    neighborLabel.text = String(neighborCount)
    
    match state:
        Global.CellState.ALIVE:
            color = Color(0.188235, 0.364706, 0.529412)
        Global.CellState.DEAD:
            color = Color(0.15,0.15,0.15)
            
            

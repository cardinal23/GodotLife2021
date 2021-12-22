extends ColorRect

class_name Cell

enum State {ALIVE, DEAD}
export(State) var state = State.DEAD

var position: Vector2
onready var positionLabel = $PositionLabel

func _ready():
    pass # Replace with function body.
    
func isAlive():
    return state == State.ALIVE
    
func isDead():
    return state == State.DEAD
    
func markAsAlive():
    state = State.ALIVE
    
func markAsDead():
    state = State.DEAD
         
func toggledState():
    if state == State.ALIVE:
        return State.DEAD
    elif state == State.DEAD:
        return State.ALIVE

func update():
    var positionString = "%s,%s"
    positionLabel.text = positionString % [position.x, position.y]
    
    match state:
        State.ALIVE:
            color = Color(0.188235, 0.364706, 0.529412)
        State.DEAD:
            color = Color(0.15,0.15,0.15)
            

extends Node2D

var tick = 0
var Cell = preload("res://Cell.tscn")

var cell_size := 40
var grid_size: Vector2

func _init():
    var size = Vector2(1920, 1080)
    print("Screen size: ", size)
    grid_size.x = size.x / cell_size
    grid_size.y = size.y / cell_size
    print(grid_size)
    
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass
    
func _input(event):
    if event is InputEventMouseButton:
        if event.pressed:
            print("Mouse click at: ", event.position)
            var cell_position = Vector2(
                int(event.position.x / cell_size),
                int(event.position.y / cell_size)
            )
            
            print(cell_position)
            var cell = Cell.instance()
            cell.rect_position = Vector2(
                cell_position.x * cell_size,
                cell_position.y * cell_size
            )
            add_child(cell)
    
